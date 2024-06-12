import 'package:al_madina_traders/app/constants/firebase.dart';
import 'package:al_madina_traders/app/modules/add_product/Model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProductController extends GetxController {
  final brandController = TextEditingController();
  final inventoryController = TextEditingController();
  final sizeController = TextEditingController();
  final quantityController = TextEditingController();
  final actualPriceController = TextEditingController();
  final consumerPriceController = TextEditingController();
  final dateTimeController = TextEditingController();
  final discountController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var selectedType = 'None'.obs;
  var type = ['None', 'Electronic', 'Battery', 'Senatory', 'PPR', 'Cooler', 'Paint'];

  Future<void> dateTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(combinedDateTime);
        dateTimeController.text = formattedDateTime;
      }
    }
  }

  void addProduct() {
    if (formKey.currentState?.validate() == true) {
      try {
        ProductModel productModel = ProductModel(
          productBrand: brandController.text,
          productName: inventoryController.text,
          productSize: sizeController.text,
          productQuantity: quantityController.text,
          productActualPrice: actualPriceController.text,
          productConsumerPrice: consumerPriceController.text,
          dateTime: dateTimeController.text,
          type: selectedType.value,
          discount: discountController.text,
          documentId: '',
        );

        productCollection
            .where('productBrand', isEqualTo: productModel.productBrand.toLowerCase())
            .where('productName', isEqualTo: productModel.productName.toLowerCase())
            .where('productSize', isEqualTo: productModel.productSize.toLowerCase())
            .where('type', isEqualTo: productModel.type.toLowerCase())
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            print("Product already exists");
            value.docs.forEach((document) {
              int currentQuantity = int.parse(document['productQuantity']);
              int newQuantity = currentQuantity + int.parse(productModel.productQuantity);

              // Update the quantity and add the change record in an array
              document.reference.update({
                'productQuantity': newQuantity.toString(),
                'productActualPrice': productModel.productActualPrice.toString(),
                'quantityChanges': FieldValue.arrayUnion([{
                  'addedQuantity': productModel.productQuantity,
                  'dateTime': productModel.dateTime,
                }])
              }).then((_) {
                Get.snackbar('Success', 'Product quantity updated successfully');
                print("Quantity and price added and record updated");
                disposeTextControllers();
              });
            });
          } else {
            // Product doesn't exist, add it to the collection
            print("Product does not exist, adding new product");
            productCollection.add(productModel.toMap()).then((docRef) {
              // Set the document ID in the product model
              productModel.documentId = docRef.id;

              // Initialize the quantityChanges array with the first record
              docRef.update({
                'quantityChanges': FieldValue.arrayUnion([{
                  'addedQuantity': productModel.productQuantity,
                  'dateTime': productModel.dateTime,
                }]),
                'documentId': docRef.id, // Update Firestore with the document ID
              }).then((_) {
                Get.snackbar('Success', 'Product added successfully');
                disposeTextControllers();
              });
            });
          }
        });
      } catch (exception) {
        Get.snackbar('Fail', exception.toString());
        if (kDebugMode) {
          print(exception);
        }
      }
    } else {
      Get.snackbar('Error', 'Please fill in all fields correctly');
    }
  }

  void disposeTextControllers() {
    // Clear text in all controllers
    brandController.clear();
    inventoryController.clear();
    sizeController.clear();
    quantityController.clear();
    actualPriceController.clear();
    consumerPriceController.clear();
    dateTimeController.clear();
    selectedType.value = 'None'; // Set back to initial value
  }
}