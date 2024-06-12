import 'package:al_madina_traders/app/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/model/sold_product_model.dart';
import '../controllers/remaing_amounts_controller.dart';

class RemaingAmountsView extends GetView<RemaingAmountsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Remaining Amounts',
          style: CustomFontStyle.heading,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.remainingAmounts.isEmpty) {
          return const Center(
            child: Text('No records found with remaining amounts'),
          );
        } else {
          return ListView.builder(
            itemCount: controller.remainingAmounts.length,
            itemBuilder: (context, index) {
              SoldProductModel record = controller.remainingAmounts[index];
              return ListTile(
                title: Text(record.userName,style: CustomFontStyle.med,),
                subtitle: Text('Remaining Amount: ${record.remainingAmount}',style: CustomFontStyle.normal,),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showUpdateDialog(context, record);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showUpdateDialog(BuildContext context, SoldProductModel record) {
    TextEditingController remainingAmountController =
        TextEditingController(text: record.remainingAmount);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Remaining Amount'),
          content: TextField(
            controller: remainingAmountController,
            decoration: InputDecoration(labelText: 'Remaining Amount'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.updateRemainingAmount(
                    record.userName,record.userContact, record.remainingAmount ,remainingAmountController.text,record.paidAmount);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}