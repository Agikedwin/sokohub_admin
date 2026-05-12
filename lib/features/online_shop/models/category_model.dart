import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String? parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId,
  });

  /// Empty helper Function
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        parentId: '',
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Create CategoryModel from JSON (Firestore / API)
  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      parentId: json['ParentId'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  /// Create CategoryModel from Firebase DocumentSnapshot
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>  document) {
    if(document.data() != null){
      final data = document.data()!;
    
    return CategoryModel(
      id: document.id,
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      parentId: data['ParentId'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
    );
  }else {
    return CategoryModel.empty();

  }
  }
}