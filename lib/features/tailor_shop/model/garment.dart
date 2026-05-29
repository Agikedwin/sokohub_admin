import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class GarmentModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  GarmentModel({
    required this.id,
    required this.name,
    required this.image,
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
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
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
    String? parentId,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
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