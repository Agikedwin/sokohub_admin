import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class AccessoryModel {
  String id;
  String name;
  String image;
  double unitCost;
  double? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;

  AccessoryModel({
    required this.id,
    required this.name,
    required this.unitCost,
    required this.image,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

  /// Empty helper Function
  static AccessoryModel empty() => AccessoryModel(
        id: '',
        name: '',
        image: '',
        unitCost: 0.0,
        quantity: 0.0,
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
       'Id': id,
      'Name': name,
      'Image': image,
      'UnitCost': unitCost,
      'Quantity': quantity,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
  return AccessoryModel(
    id: json['Id'] ?? '',
    name: json['Name'] ?? '',
    unitCost: (json['UnitCost'] ?? 0.0).toDouble(),
    quantity: (json['Quantity'] ?? 0.0).toDouble(),
    image: json['Image'] ?? '',

    createdAt: json['CreatedAt'] != null
    ? (json['CreatedAt'] is Timestamp
        ? (json['CreatedAt'] as Timestamp).toDate()
        : DateTime.tryParse(json['CreatedAt'].toString()))
    : null,

updatedAt: json['UpdatedAt'] != null
    ? (json['UpdatedAt'] is Timestamp
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : DateTime.tryParse(json['UpdatedAt'].toString()))
    : null,
  );
}



  /// Create CategoryModel from Firebase DocumentSnapshot
 factory AccessoryModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  final data = document.data();

  if (data == null) return AccessoryModel.empty();

  return AccessoryModel(
    id: document.id,
    name: data['Name'] ?? '',
    unitCost: data['UnitCost'] ?? 0.0,
    quantity: data['Quantity'] ?? 0.0,
    image: data['Image'] ?? '',

    createdAt: data['CreatedAt'] != null
        ? (data['CreatedAt'] as Timestamp).toDate()
        : null,

    updatedAt: data['UpdatedAt'] != null
        ? (data['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}

  /// CopyWith Method
  AccessoryModel copyWith({
    String? id,
    String? name,
    String? image,
    double? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccessoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unitCost: unitCost ,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'AccessoryModel(name: $name, unitCost : $unitCost)';
  }
}