class ProductModel {
  final String productBrand;
  final String productName;
  final String productSize;
  final String productQuantity;
  final String productActualPrice;
  final String productConsumerPrice;
  final String dateTime;
  final String type;
  final String discount;
  String documentId;

  ProductModel({
    required this.productBrand,
    required this.productName,
    required this.productSize,
    required this.productQuantity,
    required this.productActualPrice,
    required this.productConsumerPrice,
    required this.dateTime,
    required this.type,
    required this.discount,
    this.documentId = '',
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, {String? docId}) {
    return ProductModel(
      productBrand: data['productBrand'],
      productName: data['productName'],
      productSize: data['productSize'],
      productQuantity: data['productQuantity'],
      productActualPrice: data['productActualPrice'],
      productConsumerPrice: data['productConsumerPrice'],
      dateTime: data['dateTime'],
      type: data['type'],
      discount: data['discount'],
      documentId: docId ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productBrand': productBrand,
      'productName': productName,
      'productSize': productSize,
      'productQuantity': productQuantity,
      'productActualPrice': productActualPrice,
      'productConsumerPrice': productConsumerPrice,
      'dateTime': dateTime,
      'type': type,
      'discount': discount,
      'documentId': documentId,
    };
  }

  @override
  String toString() {
    return 'ProductModel{productBrand: $productBrand, productName: $productName, productSize: $productSize, productQuantity: $productQuantity, productActualPrice: $productActualPrice, productConsumerPrice: $productConsumerPrice, dateTime: $dateTime, type: $type, discount: $discount, documentId: $documentId}';
  }
}