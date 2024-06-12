import 'package:get/get.dart';

import '../controllers/remaing_amounts_controller.dart';

class RemaingAmountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemaingAmountsController>(
      () => RemaingAmountsController(),
    );
  }
}