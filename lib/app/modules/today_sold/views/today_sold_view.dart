import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/fonts.dart';
import '../controllers/today_sold_controller.dart';

class TodaySoldView extends GetView<TodaySoldController> {
  const TodaySoldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Today's Total Sold",
            style: CustomFontStyle.heading,
          ),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: controller.categories.map((category) => Tab(text: category)).toList(),
            onTap: (index) {
              String selectedCategory = controller.categories[index];
              controller.filterSoldProducts(selectedCategory);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final totalSold = controller.soldProducts.length;
                return Text(
                  "Total sold today: $totalSold",
                  style: CustomFontStyle.med,
                );
              }),
              Expanded(
                child: TabBarView(
                  children: controller.categories.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          final benefit = controller.categoryBenefits[category] ?? 0.0;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total Sold Price: ${controller.totalSoldPrice}',
                                style: CustomFontStyle.med,
                              ),
                              Text(
                                'Remaining Total: ${controller.remainingTotal}',
                                style: CustomFontStyle.med,
                              ),
                              Text(
                                'Total Benefit ($category): ${benefit.toStringAsFixed(2)}',
                                style: CustomFontStyle.med,
                              ),
                            ],
                          );
                        }),
                        Expanded(
                          child: Obx(() {
                            if (controller.filteredSoldProducts.isEmpty) {
                              return Center(
                                child: Text(
                                  "No products sold today",
                                  style: CustomFontStyle.heading,
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: controller.filteredSoldProducts.length,
                              itemBuilder: (context, index) {
                                final product = controller.filteredSoldProducts[index];
                                List<String> productIDs = List<String>.from(product.soldProductIDs);
                                List<String> quantities = (product.soldQuantity.split(',')).map((q) => q.trim()).toList();

                                return ListTile(
                                  title: Text(
                                    product.userName,
                                    style: CustomFontStyle.med,
                                  ),
                                  subtitle: Text(
                                    'Contact: ${product.userContact}\n'
                                        'Total Price: ${product.totalPrice}\n'
                                        'Paid Amount: ${product.paidAmount}\n'
                                        'Remaining Amount: ${product.remainingAmount}\n'
                                        'Date: ${product.date}',
                                    style: CustomFontStyle.normal,
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(productIDs.length, (i) {
                                      String productId = productIDs[i];
                                      double quantity = double.tryParse(quantities[i]) ?? 0.0;
                                      return FutureBuilder<Map<String, dynamic>>(
                                        future: controller.getProductDetails(productId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Expanded(child: const CircularProgressIndicator());
                                          }
                                          if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          }
                                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                            return const Text('Product details not found');
                                          }
                                          final productDetails = snapshot.data!;
                                          final productName = productDetails['productName'];
                                          final productBrand = productDetails['productBrand'];
                                          return Expanded(
                                            child: Text(
                                              '$productName ($quantity) - $productBrand',
                                              style: CustomFontStyle.normal,
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}