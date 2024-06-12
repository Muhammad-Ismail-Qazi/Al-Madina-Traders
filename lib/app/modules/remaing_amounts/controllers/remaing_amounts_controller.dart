import 'package:al_madina_traders/app/constants/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../cart/model/sold_product_model.dart';

class RemaingAmountsController extends GetxController {
  var remainingAmounts = <SoldProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRemainingAmounts();
  }

  void fetchRemainingAmounts() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestoreInstace
          .collection('users')
          .where('remainingAmount', isGreaterThan: '0.0')
          .get();

      List<SoldProductModel> fetchedRecords = querySnapshot.docs.map((doc) {
        return SoldProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      remainingAmounts.assignAll(fetchedRecords);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch remaining amounts');
    }
  }

  Future<void> updateRemainingAmount(String userName, String userContact, String remainingAmount, String newRemainingAmount,String paidAmount) async {
    try {
      // Perform a query to find the document matching the provided parameters
      QuerySnapshot querySnapshot = await firebaseFirestoreInstace.collection('users')
          .where('userName', isEqualTo: userName)
          .where('userContact', isEqualTo: userContact)
          .where('remainingAmount', isEqualTo: remainingAmount)
          .where('paidAmount', isEqualTo: paidAmount)
          .get();
      double? _remaingAmount=double.tryParse(remainingAmount);
      double? _paidAmount=double.tryParse(paidAmount);
      double _paidAmounts=_remaingAmount!+_paidAmount!;

      if (querySnapshot.docs.isNotEmpty) {
        // Update the first matching document
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'remainingAmount': newRemainingAmount,
          'paidAmount':   _paidAmounts.toString(),
        });
        fetchRemainingAmounts();
      } else {
        Get.snackbar('Error', 'No matching record found to update');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update remaining amount');
    }
  }
}