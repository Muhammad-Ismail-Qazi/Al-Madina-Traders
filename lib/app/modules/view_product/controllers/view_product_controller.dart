import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/firebase.dart';
import '../../add_product/Model/product_model.dart';

class ViewProductController extends GetxController {
  final searchController = TextEditingController();


  var filterProductList = <ProductModel>[].obs;
  var allProductList = <ProductModel>[];

  @override
  void onInit() {
    super.onInit();
    getProductData();
    searchController.addListener(_filterProducts);

  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> getProductData() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();

    for (var document in querySnapshot.docs) {
      ProductModel productModel=ProductModel.fromMap(document.data() as Map<String, dynamic>);
      allProductList.add(productModel);
      }

      filterProductList.value = allProductList;
    } catch (exception) {
      print(exception);
    }
  }

  void _filterProducts() {
    final controllerText = searchController.text.toLowerCase();

    if (controllerText.isEmpty) {
      filterProductList.value =
          allProductList; // Reset to original list if search text is empty
    } else {
      final filteredProducts = allProductList.where((product) {
        return product.productName.toLowerCase().contains(controllerText) ||
            product.productBrand.toLowerCase().contains(controllerText);
      }).toList();

      filterProductList.value = filteredProducts;
    }
  }
}