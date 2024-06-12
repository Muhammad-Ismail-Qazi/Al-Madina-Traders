import 'package:al_madina_traders/app/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../components/textfield.dart';
import '../../../constants/fonts.dart';
import '../controllers/add_product_controller.dart';

import '../validator/validation.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CustomTextField(
                  textFieldController: controller.brandController,
                  hint: 'Brand',
                  validator: (value) =>
                      FormValidation.validateProductName(value),
                  keyboardType: TextInputType.text,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.inventoryController,
                  hint: 'Inventory',
                  validator: (value) => FormValidation.validateInventory(value),
                  keyboardType: TextInputType.text,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.sizeController,
                  hint: 'Size',
                  validator: (value) => FormValidation.validateSize(value),
                  keyboardType: TextInputType.text,
                ),
                Spaces.y2,
                Obx(
                      () => Container(
                    color: Colors.white70,
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      elevation: 2,
                      isExpanded: true,

                      // Initial Value
                      value: controller.selectedType.value,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: controller.type.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectedType.value = newValue;
                        }
                      },
                    ),
                  ),
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.quantityController,
                  hint: 'Quantity',
                  validator: (value) => FormValidation.validateQuantity(value),
                  keyboardType: TextInputType.number,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.actualPriceController,
                  hint: 'Actual Price',
                  validator: (value) =>
                      FormValidation.validateActualPrice(value),
                  keyboardType: TextInputType.number,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.discountController,
                  hint: 'Discount percentage',
                  validator: (value) =>
                      FormValidation.validateActualPrice(value),
                  keyboardType: TextInputType.number,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.consumerPriceController,
                  hint: 'Consumer Price',
                  validator: (value) =>
                      FormValidation.validateConsumerPrice(value),
                  keyboardType: TextInputType.number,
                ),
                Spaces.y2,
                CustomTextField(
                  textFieldController: controller.dateTimeController,
                  hint: 'Date and Time',
                  validator: (value) => FormValidation.validateDateTime(value),
                  onTap: () => controller.dateTimePicker(context),
                  keyboardType: TextInputType.number,
                ),
                Spaces.y2,
                ElevatedButton(
                  onPressed: () {
                    controller.addProduct();
                  },
                  child: Text('Save Product', style: CustomFontStyle.heading),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}