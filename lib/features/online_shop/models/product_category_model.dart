import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String? id;
  String productId;
  String categoryId;

  ProductCategoryModel({
    this.id,
    required this.productId,
    required this.categoryId,
  });

  /// Empty helper function
  static ProductCategoryModel empty() => ProductCategoryModel(
        id: '',
        productId: '',
        categoryId: '',
      );

  /// Convert model to JSON (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  /// Create Brand from JSON (Firestore / API)
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json[''] ?? '',
      productId: json['productId'] ?? '',
      categoryId: json['categoryId'] ?? '',
    );
  }

  /// Create Brand from Firebase DocumentSnapshot
  factory ProductCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    
    if (data != null) {
      return ProductCategoryModel(
        id: document.id,
        productId: data['productId'] ?? document.id,
        categoryId: data['categoryId'] ?? '',
      );
    } else {
      return ProductCategoryModel.empty();
    }
  }
}