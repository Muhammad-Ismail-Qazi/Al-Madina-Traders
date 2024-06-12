// CartView.dart
import 'package:al_madina_traders/app/components/button.dart';
import 'package:al_madina_traders/app/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/textfield.dart';
import '../../../constants/spaces.dart';
import '../../add_product/validator/validation.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() {
            return Column(
              children: [
                Text(
                  "Total Price: ${controller.totalPrice.value.toStringAsFixed(2)}",
                  style: CustomFontStyle.heading,
                ),
                Text(
                  "Total Discount: ${controller.totalDiscount.value.toStringAsFixed(2)}",
                  style: CustomFontStyle.heading,
                ),
                Text(
                  "Price to pay: ${(controller.totalPrice.value - controller.totalDiscount.value).toStringAsFixed(2)}",
                  style: CustomFontStyle.heading,
                ),
              ],
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.receivedItems.isEmpty) {
                return Center(
                  child: Text(
                    "No Item is selected",
                    style: CustomFontStyle.heading,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.receivedItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.receivedItems[index];
                    double discountPercentage = double.tryParse(item.discount) ?? 0.0;
                    double consumerPrice = double.tryParse(item.productConsumerPrice) ?? 0.0;
                    double finalPrice = consumerPrice * (1 - discountPercentage / 100);
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.black12,
                        ),
                        child: ListTile(
                          title: Text(
                            '${item.productName}-${item.productBrand}',
                            style: CustomFontStyle.med,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Size: ${item.productSize}\nPrice: ${item.productConsumerPrice}\nDiscount: ${item.discount}%\nPay: ${finalPrice.toStringAsFixed(2)}',
                                style: CustomFontStyle.normal,
                              ),
                              Spaces.y1,
                              CustomTextField(
                                validator: (value) => FormValidation.validateQuantity(value),
                                onChanged: (value) => controller.updateQuantity(value, index), // Update quantity on change
                                textFieldController: controller.quantityControllers[index],
                                hint: 'Quantity',
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              controller.removeItem(index);
                            },
                            child: Text(
                              "Remove",
                              style: CustomFontStyle.med,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Obx(
                () => CustomButton(
              onPressed: controller.receivedItems.isEmpty
                  ? null
                  : () {
                Get.defaultDialog(
                  title: "Enter User Details ${(controller.totalPrice.value - controller.totalDiscount.value).toStringAsFixed(2)}",
                  titleStyle: CustomFontStyle.med,
                  content: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          textFieldController: controller.nameController,
                          hint: "Name",
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FormValidation.validateUserName(value),
                        ),
                        Spaces.y1,
                        CustomTextField(
                          textFieldController: controller.contactController,
                          hint: "Contact",
                          keyboardType: TextInputType.phone,
                        ),
                        Spaces.y1,
                        CustomTextField(
                          textFieldController: controller.paidAmountController,
                          hint: "Paid-amount",
                          keyboardType: TextInputType.number,
                          validator: (value) => FormValidation.validatePaidAmount(value),
                        ),
                        Spaces.y1,
                        Obx(() {
                          return Text(
                            "Remaining amount: ${controller.remainingAmount.value.toStringAsFixed(2)}",
                            style: CustomFontStyle.med,
                          );
                        }),
                      ],
                    ),
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      controller.sellProduct();
                    },
                    child: Text("Sold", style: CustomFontStyle.med),
                  ),
                  cancel: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: Text("Cancel", style: CustomFontStyle.med),
                  ),
                );
              },
              text: "Sell",
            ),
          ),
        ],
      ),
    );
  }
}