class SoldProductModel {
  final String userName;
  final String userContact;
  final String totalPrice;
  final String paidAmount;
  final String remainingAmount;
  final List<String> soldProductIDs;
  final String soldQuantity;
  final String date;

  SoldProductModel({
    required this.userName,
    required this.userContact,
    required this.totalPrice,
    required this.paidAmount,
    required this.remainingAmount,
    required this.soldProductIDs,
    required this.soldQuantity,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userContact': userContact,
      'totalPrice': totalPrice,
      'paidAmount': paidAmount,
      'remainingAmount': remainingAmount,
      'soldProductIDs': soldProductIDs,
      'soldQuantity': soldQuantity,
      'date': date,
    };
  }

  factory SoldProductModel.fromMap(Map<String, dynamic> map) {
    return SoldProductModel(
      userName: map['userName'],
      userContact: map['userContact'],
      totalPrice: map['totalPrice'],
      paidAmount: map['paidAmount'],
      remainingAmount: map['remainingAmount'],
      soldProductIDs: List<String>.from(map['soldProductIDs']),
      soldQuantity: map['soldQuantity'],
      date: map['date'],
    );
  }

  @override
  String toString() {
    return 'SoldProductModel{userName: $userName, userContact: $userContact, totalPrice: $totalPrice, paidAmount: $paidAmount, remainingAmount: $remainingAmount, soldQuantity: $soldQuantity, date: $date}';
  }
}