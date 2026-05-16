import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String? id;
  String brandId;
  String categoryId;

  BrandCategoryModel({
    this.id,
    required this.brandId,
    required this.categoryId,
  });

  /// Empty helper function
  static BrandCategoryModel empty() => BrandCategoryModel(
        brandId: '',
        categoryId: '',
      );

  /// Convert model to JSON (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }

  /// Create Brand from JSON (Firestore / API)
  factory BrandCategoryModel.fromJson(Map<String, dynamic> json) {
    return BrandCategoryModel(
      brandId: json['brandId'] ?? '',
      categoryId: json['categoryId'] ?? '',
    );
  }

  /// Create Brand from Firebase DocumentSnapshot
  factory BrandCategoryModel.fromSnapshot(
      DocumentSnapshot snapShot) {
    final data = snapShot.data() as Map<String, dynamic>;

    return BrandCategoryModel(
      id: snapShot.id,
      brandId: data['brandId'] as String,
      categoryId: data['categoryId'] as String
    );
    }
}