import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class BrandModel {
  String id;
  String name;
  String image;
  int? productCount;
  bool? isFeatured;
    DateTime? createdAt;
  DateTime? updatedAt;

  // Not Mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
     this.isFeatured,
     this.productCount,
      this.createdAt,
          this.updatedAt,
          this.brandCategories
        });

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

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
       'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
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
      createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,

    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
  
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
      createdAt: data['CreatedAt'] != null
        ? (data['CreatedAt'] as Timestamp).toDate()
        : null,

    updatedAt: data['UpdatedAt'] != null
        ? (data['UpdatedAt'] as Timestamp).toDate()
        : null,
  
    );
  }else {
    return BrandModel.empty();

  }
  }
}