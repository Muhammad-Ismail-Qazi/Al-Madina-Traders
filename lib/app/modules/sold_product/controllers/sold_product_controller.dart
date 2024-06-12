import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/firebase.dart';
import '../../add_product/Model/product_model.dart';

class SoldProductController extends GetxController {
  final searchController = TextEditingController();

  var allProductList = <ProductModel>[];

  var filterProductList = <ProductModel>[].obs;

  var selectedProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterProducts);
    getProductData();
  }

  Future<void> getProductData() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();
      for (var document in querySnapshot.docs) {
        String documentId = document.id;
        ProductModel productModel = ProductModel.fromMap(document.data() as Map<String, dynamic>, docId: documentId);
        allProductList.add(productModel);
      }
      filterProductList.value = allProductList;
      print(filterProductList);
    } catch (exception) {
      print(exception);
    }
  }


  void _filterProducts() {
    final controllerText = searchController.text.toLowerCase();

    if (controllerText.isEmpty) {
      filterProductList.value = allProductList;
    } else {
      final filteredProducts = allProductList.where((product) {
        return product.productName.toLowerCase().contains(controllerText) ||
            product.productBrand.toLowerCase().contains(controllerText);
      }).toList();

      filterProductList.value = filteredProducts;
    }
  }

  void addToCart(ProductModel product) {
    if (!selectedProducts.contains(product)) {
      selectedProducts.add(product);
      Get.snackbar(
        "Product Added",
        "${product.productName} has been added to the cart.",
      );
    } else {
      Get.snackbar(
        "Product Already Added",
        "${product.productName} is already in the cart.",
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}