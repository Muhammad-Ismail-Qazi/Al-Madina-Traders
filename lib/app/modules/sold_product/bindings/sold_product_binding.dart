import 'package:get/get.dart';

import '../controllers/sold_product_controller.dart';

class SoldProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SoldProductController>(
      () => SoldProductController(),
    );
  }
}
