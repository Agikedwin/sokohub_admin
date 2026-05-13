import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  int? productCount;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
     this.isFeatured,
     this.productCount,
  });

  /// Empty helper Function
  static BrandModel empty() => BrandModel(
        id: '',
        name: '',
        image: '',
        
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'productCount': productCount,
      'IsFeatured': isFeatured,
    };
  }

  /// Create Brand from JSON (Firestore / API)
  factory BrandModel.fromJson(Map<String, dynamic> json, String id) {
    return BrandModel(
      id: id,
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      productCount: json['ProductCount'] ?? 0,
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  /// Create Brand from Firebase DocumentSnapshot
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>  document) {
    if(document.data() != null){
      final data = document.data()!;
    
    return BrandModel(
      id: document.id,
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productCount: data['productCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }else {
    return BrandModel.empty();

  }
  }
}