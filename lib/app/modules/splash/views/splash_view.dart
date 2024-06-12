import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/spaces.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  const EdgeInsets.all(12.0),
        child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: Spaces.normY(10.h)
              ),
              child: Image.asset('assets/logo.png')),
        ),
      ),
    );
  }
}