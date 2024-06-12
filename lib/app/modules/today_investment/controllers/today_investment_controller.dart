
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../constants/firebase.dart';

class TodayInvestmentController extends GetxController {
  // List to hold today's investments
  var todayInvestments = <Map<String, dynamic>>[].obs;
  var filteredInvestments = <Map<String, dynamic>>[].obs;
  var totalTodayInvestment = 0.0.obs;

  // List of categories
  final List<String> categories = ['All', 'Electronic', 'Battery', 'Senatory', 'PPR', 'Cooler', 'Paint'];

  @override
  void onInit() {
    super.onInit();
    getTodayInvestment();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getTodayInvestment() async {
    try {
      DateTime now = DateTime.now();
      String todayDate = DateFormat('yyyy-MM-dd').format(now).toLowerCase();

      QuerySnapshot querySnapshot = await productCollection.get();

      todayInvestments.clear();
      totalTodayInvestment.value = 0.0;  // Reset the total investment

      for (var document in querySnapshot.docs) {
        List<dynamic> quantityChanges = document['quantityChanges'] ?? [];


        for (var change in quantityChanges) {
          if ((change['dateTime'] as String).toLowerCase().startsWith(todayDate)) {
            var addedQuantity = double.parse(change['addedQuantity']);
            var productActualPrice = double.parse(document['productActualPrice']);
            var investmentAmount = addedQuantity * productActualPrice;

            var investment = {
              'productName': document['productName'],
              'productBrand': document['productBrand'],
              'productSize': document['productSize'],
              'productQuantity': document['productQuantity'],
              'productActualPrice': productActualPrice.toString(),
              'productConsumerPrice': document['productConsumerPrice'],
              'type': document['type'],
              'addedQuantity': addedQuantity.toString(),
              'dateTime': change['dateTime'],
              'investmentAmount': investmentAmount.toString(),
            };
            todayInvestments.add(investment);
            totalTodayInvestment.value += investmentAmount;
          }
        }
      }
      // Initialize with all investments
      filterInvestments(categories[0]);
      print("Today's investments fetched successfully. Total investment: \$${totalTodayInvestment.value}");
    } catch (e) {
      print("Error fetching today's investments: $e");
    }
  }

  void filterInvestments(String type) {
    double total = 0.0;
    if (type == 'All') {
      filteredInvestments.assignAll(todayInvestments);



      total = todayInvestments.fold(0, (sum, investment) => sum + double.parse(investment['investmentAmount']));
    } else {
      var filtered = todayInvestments.where((investment) => investment['type'].toLowerCase() == type.toLowerCase()).toList();
      filteredInvestments.assignAll(filtered);
      total = filtered.fold(0, (sum, investment) => sum + double.parse(investment['investmentAmount']));
    }
    totalTodayInvestment.value = total;
  }
}