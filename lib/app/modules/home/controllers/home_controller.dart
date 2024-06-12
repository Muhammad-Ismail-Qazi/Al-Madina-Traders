import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../constants/firebase.dart';
import '../../add_product/Model/product_model.dart';

class HomeController extends GetxController {
  RxDouble abundant = RxDouble(0);
  RxDouble limited = RxDouble(0);
  RxDouble normal = RxDouble(0);


  @override
  void onInit() {
    super.onInit();
    getProductData();
  }

  Future<void> getProductData() async {
    try {
      abundant.value = 0;
      limited.value = 0;
      normal.value = 0;
      QuerySnapshot querySnapshot = await productCollection.get();

      for (var document in querySnapshot.docs) {
        ProductModel productModel =
            ProductModel.fromMap(document.data() as Map<String, dynamic>);
        double productQuantity = double.parse(productModel.productQuantity);

        if (productQuantity < 5) {
          limited.value += 1;
        } else if (productQuantity > 15) {
          abundant.value += 1;
        } else if (productQuantity >= 5 && productQuantity <= 15) {
          normal.value += 1;
        }
      }

      // Print for debugging
      print(
          "Abundant: ${abundant.value}, Limited: ${limited.value}, Normal: ${normal.value}");
    } catch (exception) {
      print(exception);
    }
  }
}