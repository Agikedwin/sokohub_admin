import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class GarmentModel {
  String id;
  String name;
  String image;
  String parentId;
  double wage;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  GarmentModel({
    required this.id,
    required this.name,
    required this.image,
    required this.wage,
     this.isFeatured = true,
     this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

  /// Empty helper Function
  static GarmentModel empty() => GarmentModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        parentId: '',
        wage: 0.0,
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'Wage':wage,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }
factory GarmentModel.fromJson(Map<String, dynamic> json) {
  
  return GarmentModel(
    id: json['Id'] ?? '',
    name: json['Name'] ?? '',
    image: json['Image'] ?? '',
    wage: (json['Wage'] ?? 0).toDouble(),
    parentId: json['ParentId'] ?? '',
    isFeatured: json['IsFeatured'] ?? false,
    createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}


  /// Create CategoryModel from Firebase DocumentSnapshot
 factory GarmentModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  final data = document.data();

  if (data == null) return GarmentModel.empty();

  return GarmentModel(
    id: document.id,
    name: data['Name'] ?? '',
    image: data['Image'] ?? '',
    wage:  data['Wage'] ?? 0.0,
    parentId: data['ParentId'] ?? '',
    isFeatured: data['IsFeatured'] ?? false,

    createdAt: data['CreatedAt'] != null
        ? (data['CreatedAt'] as Timestamp).toDate()
        : null,

    updatedAt: data['UpdatedAt'] != null
        ? (data['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}

  /// CopyWith Method
  GarmentModel copyWith({
    String? id,
    String? name,
    String? image,
    double? wage,
    String? parentId,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      wage:  wage ?? this.wage,
      parentId: parentId ?? this.parentId,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GarmentModel(name: $name)';
  }
}