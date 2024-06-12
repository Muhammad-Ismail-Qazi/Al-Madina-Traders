import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../controllers/today_investment_controller.dart';

class TodayInvestmentView extends GetView<TodayInvestmentController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Today's Investment",
            style: CustomFontStyle.heading,
          ),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: controller.categories.map((category) => Tab(text: category)).toList(),
            onTap: (index) {
              controller.filterInvestments(controller.categories[index]);
            },
          ),
        ),
        body: Column(
          children: [
            Obx(() => Text(
              '\pkr ${controller.totalTodayInvestment.value.toStringAsFixed(2)}',
              style: CustomFontStyle.heading,
            )),
            Expanded(
              child: Obx(() {
                if (controller.filteredInvestments.isEmpty) {
                  return Center(
                      child: Text('No investments found for today',
                          style: CustomFontStyle.heading));
                }
                return ListView.builder(
                  itemCount: controller.filteredInvestments.length,
                  itemBuilder: (context, index) {
                    final investment = controller.filteredInvestments[index];

                    return Card(
                      margin: const EdgeInsets.all(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${investment['productName']} - ${investment['productBrand']}',
                              style: CustomFontStyle.med,
                            ),
                            Spaces.y1,
                            Text('Size: ${investment['productSize']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text('Total Quantity: ${investment['productQuantity']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text('Actual Price: ${investment['productActualPrice']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text(
                                'Consumer Price: ${investment['productConsumerPrice']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text('Added Quantity: ${investment['addedQuantity']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text('Date: ${investment['dateTime']}',
                                style: CustomFontStyle.normal),
                            Spaces.y1,
                            Text('Type: ${investment['type']}',
                                style: CustomFontStyle.normal),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}