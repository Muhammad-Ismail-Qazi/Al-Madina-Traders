import 'package:get/get.dart';

import '../controllers/track_record_controller.dart';

class TrackRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackRecordController>(
      () => TrackRecordController(),
    );
  }
}
