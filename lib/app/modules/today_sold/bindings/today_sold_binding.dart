import 'package:get/get.dart';

import '../controllers/today_sold_controller.dart';

class TodaySoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodaySoldController>(
      () => TodaySoldController(),
    );
  }
}
