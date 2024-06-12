import 'package:get/get.dart';

import '../controllers/limited_product_controller.dart';

class LimitedProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LimitedProductController>(
      () => LimitedProductController(),
    );
  }
}
