import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../constants/firebase.dart';
import '../../cart/model/sold_product_model.dart';

class TodaySoldController extends GetxController {
  RxList<SoldProductModel> soldProducts = <SoldProductModel>[].obs;
  RxList<SoldProductModel> filteredSoldProducts = <SoldProductModel>[].obs;
  RxDouble totalSoldPrice = 0.0.obs;
  RxDouble remainingTotal = 0.0.obs;
  RxDouble totalBenefit = 0.0.obs;
  RxDouble totalActualPrice = 0.0.obs;

  // Store total benefits per category
  RxMap<String, double> categoryBenefits = <String, double>{}.obs;

  final List<String> categories = [
    'All',
    'Electronic',
    'Battery',
    'Senatory',
    'PPR',
    'Cooler',
    'Paint'
  ];

  @override
  void onInit() {
    super.onInit();
    fetchTodaySoldProducts();
  }

  void fetchTodaySoldProducts() async {
    try {
      // Get today's date in 'yyyy-MM-dd' format
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Fetch records from Firestore where the date matches today's date
      QuerySnapshot querySnapshot =
          await userCollection.where('date', isEqualTo: today).get();

      List<SoldProductModel> fetchedProducts = querySnapshot.docs.map((doc) {
        return SoldProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      double soldPrice = 0;
      double remaining = 0;
      double actualPriceTotal = 0;

      for (var product in fetchedProducts) {
        double productTotalPrice = double.tryParse(product.totalPrice) ?? 0.0;
        double productRemainingAmount =
            double.tryParse(product.remainingAmount) ?? 0.0;

        soldPrice += productTotalPrice;
        remaining += productRemainingAmount;

        List<String> productIDs = List<String>.from(product.soldProductIDs);
        List<String> quantities =
            (product.soldQuantity.split(',')).map((q) => q.trim()).toList();

        for (int i = 0; i < productIDs.length; i++) {
          String productId = productIDs[i];
          double quantity = double.tryParse(quantities[i]) ?? 0.0;

          // Fetch the actual product data
          DocumentSnapshot productDoc =
              await productCollection.doc(productId).get();
          double actualPrice = double.tryParse(
                  productDoc['productActualPrice']?.toString() ?? '0') ??
              0.0;

          actualPriceTotal += actualPrice * quantity;
        }
      }
      totalBenefit.value = 0;

      soldProducts.assignAll(fetchedProducts);
      totalSoldPrice.value = soldPrice;
      remainingTotal.value = remaining;
      totalActualPrice.value = actualPriceTotal;
      print("Total Actual Price ${totalActualPrice.value}");
      print("Total sold Price ${totalSoldPrice.value}");
      totalBenefit.value = totalSoldPrice.value - totalActualPrice.value;
      print("Total benefit Price ${totalActualPrice.value}");

      // Initialize with all products
      filterSoldProducts('All');
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch sold products: $e');
      print("Error fetching sold products: $e");
    }
  }

  Future<void> filterSoldProducts(String category) async {
    if (category == 'All') {
      // If 'All' category selected, assign all sold products to filteredSoldProducts
      filteredSoldProducts
          ..clear()..assignAll(soldProducts);
    } else {
      // Filter sold products based on the selected category
      List<SoldProductModel> filteredProducts = [];

      for (var product in soldProducts) {
        bool hasMatchingCategory = false;

        for (var soldProductId in product.soldProductIDs) {
          // Fetch the corresponding product from productCollection
          try {
            final query = productCollection
                .where('type', isEqualTo: category)
                .where('documentId', isEqualTo: soldProductId);
            final productDoc = await query.get();
            // Access the type field of the product


            if (productDoc.docs.firstOrNull?.exists == true) {
              hasMatchingCategory = true;
              break;
            }

            // String productType = productDoc.docs.firstOrNull?.exists == true
            //     ? (productDoc.docs.first.data() as Map<String, dynamic>)['type']
            //     : '';
            //
            // // String productType = productDoc['type'];
            // // Check if the product type matches the selected category
            // if (productType.toLowerCase() == category.toLowerCase()) {
            //   hasMatchingCategory = true;
            //   break; // Exit loop early if a match is found
            // }
          } catch (e) {
            print('EEEEEEEEEEEEEEEEEEEEEEE');
            print(e);
          }
        }

        if (hasMatchingCategory) {
          filteredProducts..clear()..add(product);
        }
      }

      filteredSoldProducts..clear()..assignAll(filteredProducts);
    }

    // Calculate total benefit based on the filtered products for the current category
    double filteredTotalSoldPrice = 0.0;
    double filteredTotalActualPrice = 0.0;

    print(filteredSoldProducts.length);

    for (var product in filteredSoldProducts) {
      double productTotalPrice = double.tryParse(product.totalPrice) ?? 0.0;
      filteredTotalSoldPrice += productTotalPrice;

      List<String> productIDs = List<String>.from(product.soldProductIDs);
      List<String> quantities =
          (product.soldQuantity.split(',')).map((q) => q.trim()).toList();

      for (int i = 0; i < productIDs.length; i++) {
        String productId = productIDs[i];
        double quantity = double.tryParse(quantities[i]) ?? 0.0;

        // Fetch the actual product data
        DocumentSnapshot productDoc =
            await productCollection.doc(productId).get();
        double actualPrice = double.tryParse(
                productDoc['productActualPrice']?.toString() ?? '0') ??
            0.0;

        filteredTotalActualPrice += actualPrice * quantity;
      }
    }

    // Calculate and update the total benefit for the current category
    double categoryBenefit = filteredTotalSoldPrice - filteredTotalActualPrice;
    categoryBenefits[category] = categoryBenefit;

    print("Filtered Total Benefit for $category: $categoryBenefit");
  }

  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    try {
      DocumentSnapshot productDoc =
          await productCollection.doc(productId).get();
      return productDoc.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error fetching product details: $e');
      return {};
    }
  }
}