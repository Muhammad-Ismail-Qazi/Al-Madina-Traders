import 'package:al_madina_traders/app/constants/firebase.dart';
import 'package:al_madina_traders/app/modules/cart/model/sold_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../add_product/Model/product_model.dart';

class CartController extends GetxController {
  // List to hold the passed items
  final RxList<ProductModel> receivedItems = Get.arguments as RxList<ProductModel>;
  final quantityControllers = <TextEditingController>[].obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final paidAmountController = TextEditingController();

  RxDouble remainingAmount = 0.0.obs;

  var totalPrice = 0.0.obs; // consumer total price
  var totalDiscount = 0.0.obs;
  var priceToPay = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    for (var _ in receivedItems) {
      quantityControllers.add(TextEditingController(text: "1"));
    }
    calculateTotals();
  }

  @override
  void onClose() {
    nameController.dispose();
    contactController.dispose();
    paidAmountController.dispose();
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    super.onClose();
    remainingAmount.value = 0.00;
  }

  void removeItem(int index) {
    receivedItems.removeAt(index);
    quantityControllers.removeAt(index);
    calculateTotals(); // Recalculate totals after removing an item
    update(); // This will update the UI
  }

  void calculateTotals() {
    double total = 0.0;
    double discount = 0.0;
    for (int i = 0; i < receivedItems.length; i++) {
      double consumerPrice = double.tryParse(receivedItems[i].productConsumerPrice) ?? 0.0;
      int quantity = int.tryParse(quantityControllers[i].text) ?? 1;
      double discountPercentage = double.tryParse(receivedItems[i].discount) ?? 0.0;
      total += consumerPrice * quantity;
      discount += (consumerPrice * discountPercentage / 100) * quantity;
    }
    totalPrice.value = total;
    totalDiscount.value = discount;
    priceToPay.value = total - discount;
  }

  void sellProduct() {
    if (formKey.currentState?.validate() == true) {
      try {
        double priceToPayValue = priceToPay.value;
        double paidAmount = double.tryParse(paidAmountController.text) ?? 0.0;

        if (paidAmount < 0 || paidAmount > priceToPayValue) {
          Get.snackbar('Alert', 'Please insert a valid input in paid amount');
          return;
        }

        double remaining = priceToPayValue - paidAmount;
        remainingAmount.value = remaining;
        var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

        List<String> soldProductIDs = receivedItems.map((product) => product.documentId).toList();


        // Join quantity values into a single string
        String soldQuantities = quantityControllers.map((controller) => controller.text).join(',');

        // Create the SoldProductModel object
        SoldProductModel soldProductModel = SoldProductModel(
          userName: nameController.text,
          userContact: contactController.text,
          totalPrice: priceToPayValue.toString(),
          paidAmount: paidAmount.toString(),
          remainingAmount: remaining.toString(),
          soldProductIDs: soldProductIDs,
          soldQuantity: soldQuantities,
          date: currentDate,
        );

        // Add the sold product to the Firestore collection
        userCollection.add(soldProductModel.toMap()).then((value) {
          // Update product quantities in the Firestore collection
          for (int i = 0; i < receivedItems.length; i++) {
            updateProductQuantity(receivedItems[i], int.parse(quantityControllers[i].text));
          }

          Get.snackbar('Success', 'Product sold successfully');
          Get.back(); // Close the dialog

          // Clear text controllers after selling
          nameController.clear();
          contactController.clear();
          paidAmountController.clear();
        }).catchError((error) {
          Get.snackbar('Error', 'Failed to sell product: $error');
          print(error);
        });
      } catch (e) {
        Get.snackbar('Error', 'An unexpected error occurred: $e');
        print("the error: $e");
      }
    } else {
      Get.snackbar('Missing', 'Please add the user details');
    }
  }

  void updateQuantity(String value, int index) {
    int quantity = int.tryParse(value) ?? 1;
    quantityControllers[index].text = quantity.toString();
    calculateTotals(); // Recalculate totals after updating quantity
    update(); // This will update the UI
  }

  void updateProductQuantity(ProductModel product, int soldQuantity) async {
    try {
      // Find the product document in Firestore
      QuerySnapshot querySnapshot = await productCollection
          .where('productBrand', isEqualTo: product.productBrand)
          .where('productName', isEqualTo: product.productName)
          .where('productSize', isEqualTo: product.productSize)
          .where('type', isEqualTo: product.type)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document that matches
        DocumentSnapshot doc = querySnapshot.docs.first;

        // Get the current product quantity
        int currentQuantity = int.parse(doc['productQuantity']);

        // Calculate the new quantity
        int newQuantity = currentQuantity - soldQuantity;

        // Update the product document with the new quantity
        await productCollection.doc(doc.id).update({'productQuantity': newQuantity.toString()});
      } else {
        Get.snackbar('Error', 'Product not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product quantity: $e');
      print("Error updating product quantity: $e");
    }
  }
}