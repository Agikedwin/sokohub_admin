import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.soldQuantity = 0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Create Empty func for clean code
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SoldQuantity': soldQuantity = 0,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: document['Id'] ?? '',
      sku: document['SKU'] ?? '',
      image: document['Image'] ?? '',
      description: document['Description'] ?? '',
      soldQuantity: document.containsKey('SoldQuantity') ? document['SoldQuantity'] ?? 0: 0,
      price: double.parse((document['Price'] ?? 0.0).toString()),
      salePrice: double.parse((document['SalePrice'] ?? 0.0).toString()),
      stock: document['Stock'] ?? 0,
      // Map the dynamic map from Firebase to Map<String, String>
      attributeValues: Map<String, String>.from(document['AttributeValues'] ?? {}),
    );
  }
}