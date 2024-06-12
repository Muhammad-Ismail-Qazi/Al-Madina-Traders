import 'package:get/get.dart';

import '../controllers/today_investment_controller.dart';

class TodayInvestmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayInvestmentController>(
      () => TodayInvestmentController(),
    );
  }
}
