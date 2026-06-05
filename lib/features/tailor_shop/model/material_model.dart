import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class MaterialModel {
  String id;
  String name;
  String image;
  String parentId;
  double unitCost;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  MaterialModel({
    required this.id,
    required this.name,
    required this.unitCost,
    required this.image,
     this.isFeatured = true,
     this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

  /// Empty helper Function
  static MaterialModel empty() => MaterialModel(
        id: '',
        name: '',
        image: '',
        unitCost: 0.0,
        isFeatured: false,
        parentId: '',
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'UnitCost': unitCost,
      'IsFeatured': isFeatured,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }


factory MaterialModel.fromJson(Map<String, dynamic> json) {
  return MaterialModel(
    id: json['Id'] ?? '',
    name: json['Name'] ?? '',
    unitCost: (json['UnitCost'] ?? 0).toDouble(),
    image: json['Image'] ?? '',
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
 factory MaterialModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  final data = document.data();

  if (data == null) return MaterialModel.empty();

  return MaterialModel(
    id: document.id,
    name: data['Name'] ?? '',
    unitCost: data['UnitCost'] ?? 0.0,
    image: data['Image'] ?? '',
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
  MaterialModel copyWith({
    String? id,
    String? name,
    String? image,
    String? parentId,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unitCost: unitCost ,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'MaterialModel(name: $name, unitCost : $unitCost)';
  }
}