import 'package:al_madina_traders/app/components/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants/fonts.dart';
import '../controllers/limited_product_controller.dart';

class LimitedProductView extends GetView<LimitedProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Limited Product',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.limitedData.isEmpty) {
          return Center(child: Text("No limited product you have ",style: CustomFontStyle.heading,));
        } else {
          return ListView.builder(
            itemCount: controller.limitedData.length,
            itemBuilder: (context, index) {
              final product = controller.limitedData[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(product.productQuantity,style: CustomFontStyle.heading,),
                ),
                title: Text(product.productName,style: CustomFontStyle.med,),
                subtitle: Text('Brand: ${product.productBrand}\ntype: ${product.type}',style: CustomFontStyle.normal,),
                trailing: Text('Size: ${product.productSize}',style: CustomFontStyle.normal,),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getLimitedData(), // Fetch data on button press
        child: const Icon(Icons.refresh),
      ),
    );
  }
}