import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/track_record_controller.dart';

class TrackRecordView extends GetView<TrackRecordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TrackRecordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TrackRecordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
