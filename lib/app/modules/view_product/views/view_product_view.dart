import 'package:al_madina_traders/app/components/textfield.dart';
import 'package:al_madina_traders/app/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/view_product_controller.dart';

class ViewProductView extends GetView<ViewProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Product',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              hint: 'Search',
              textFieldController: controller.searchController,
              keyboardType: TextInputType.text,
            ),
            Expanded(
              child: Obx(() {
                if (controller.filterProductList.isEmpty) {
                  return Center(
                      child: Text(
                        'No products found',
                        style: CustomFontStyle.heading,
                      ));
                }
                return ListView.builder(
                  itemCount: controller.filterProductList.length,
                  itemBuilder: (context, index) {
                    final product = controller.filterProductList[index];

                    // Parse the discount and consumer price as double
                    double discountPercentage = double.tryParse(product.discount) ?? 0.0;
                    double consumerPrice = double.tryParse(product.productConsumerPrice) ?? 0.0;

                    // Calculate the final price after discount
                    double finalPrice = consumerPrice * (1 - discountPercentage / 100);

                    return ListTile(
                      title: Text(
                        product.productName,
                        style: CustomFontStyle.med,
                      ),
                      subtitle: Text(
                        'Brand: ${product.productBrand}\nSize: ${product.productSize}\nQuantity: ${product.productQuantity}\nDiscount: ${product.discount}%\nPrice after Discount: ${finalPrice.toStringAsFixed(2)}\ntype: ${product.type}',
                        style: CustomFontStyle.normal,
                      ),
                      trailing: Text(
                        'Actual-Price: ${product.productActualPrice}\nConsumer-Price: ${product.productConsumerPrice}',
                        style: CustomFontStyle.normal,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getProductData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}