import 'package:al_madina_traders/app/constants/firebase.dart';
import 'package:al_madina_traders/app/modules/add_product/Model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LimitedProductController extends GetxController {
  var limitedData = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLimitedData();
  }

  Future<void> getLimitedData() async {
    try {
      QuerySnapshot querySnapshot = await productCollection.get();

      limitedData.clear();

      for (var document in querySnapshot.docs) {
        ProductModel productModel = ProductModel.fromMap(document.data() as Map<String, dynamic>);

        // Convert productQuantity to a double for comparison
        double productQuantity = double.parse(productModel.productQuantity);

        // Filter products with productQuantity <= 5
        if (productQuantity <= 5) {
          limitedData.add(productModel);
        }
      }
    } catch (exception) {
      print(exception);
    }
  }
}