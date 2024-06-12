import 'package:al_madina_traders/app/constants/fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';

import '../../../components/button.dart';
import '../../../constants/spaces.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is initialized
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al-Madina Traders',
          style: CustomFontStyle.heading,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
              ()=>Padding(
                padding: const EdgeInsets.all(12.0),
                child: PieChart(
                    dataMap: {
                  'Abundant': controller.abundant.value,
                  'Limited': controller.limited.value,
                  'Normal': controller.normal.value,

                    },
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: 10.h * 2.2,
                    colorList: const [
                      Colors.blue,
                      Colors.red,
                      Colors.green,
                    ],
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 10.sp,
                    centerText: "Quantity lvl",
                    centerTextStyle: CustomFontStyle.heading,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendTextStyle: TextStyle(fontSize: 12),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: true,
                    ),
                  ),
              ),
              ),
              Spaces.y1,
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  buildTypewriterAnimatedText("We're welcome to (:"),
                  buildTypewriterAnimatedText("Mustafa Kamal "),
                ],
              ),
              CustomButton(
                text: 'Add product',
                onPressed: () => Get.toNamed('/add-product'),
              ),
              CustomButton(
                text: 'View Product',
                onPressed: () => Get.toNamed('/view-product'),
              ),
              CustomButton(
                text: 'Limited Product',
                onPressed: () => Get.toNamed('/limited-product'),
              ),
              CustomButton(
                text: 'Sold Product',
                onPressed: () => Get.toNamed('/sold-product'),
              ),
              CustomButton(
                text: 'Today Investment',
                onPressed: () => Get.toNamed('/today-investment'),
              ),
              CustomButton(
                text: 'Today sold',
                onPressed: () => Get.toNamed('/today-sold'),
              ),
              CustomButton(
                text: 'Remaining amounts',
                onPressed: () => Get.toNamed('/remaing-amounts'),
              ),
              CustomButton(
                text: 'Track Record',
                onPressed: () => Get.toNamed('/track-record'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TypewriterAnimatedText buildTypewriterAnimatedText(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: CustomFontStyle.heading,
      speed: const Duration(milliseconds: 150),
    );
  }
}