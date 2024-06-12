import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/button.dart';
import '../../../components/textfield.dart';
import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../controllers/sold_product_controller.dart';

class SoldProductView extends GetView<SoldProductController> {
  const SoldProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sold Products',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Spaces.y1,
            CustomTextField(
              hint: 'Search',
              textFieldController: controller.searchController,
              keyboardType: TextInputType.text,
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.filterProductList.length,
                  itemBuilder: (context, index) {
                    final product = controller.filterProductList[index];


                    return ListTile(
                      title: Text(
                        "${product.productName}-${product.productBrand}",
                        style: CustomFontStyle.med,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price: ${product.productConsumerPrice}',
                            style: CustomFontStyle.normal,
                          ),
                          Text(
                            'size: ${product.productSize}',
                            style: CustomFontStyle.normal,
                          ),
                          Text(
                            'Type: ${product.type}',
                            style: CustomFontStyle.normal,
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed:  () =>
                    controller.addToCart(product),

                        child:  Text("Add to cart",style: CustomFontStyle.med,),
                      )
                    );
                  },
                );
              }),
            ),
            Spaces.y2,
            CustomButton(
              text: 'view cart',
              onPressed: () => Get.toNamed('/cart',arguments: controller.selectedProducts),
            ),
          ],
        ),
      ),
    );
  }
}