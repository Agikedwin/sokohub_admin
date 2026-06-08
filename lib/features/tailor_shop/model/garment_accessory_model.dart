import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class GarmentAccessoryModel {
  final String id;
  final String garmentId;
  final String accessoryId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GarmentAccessoryModel({
    required this.id,
    required this.garmentId,
    required this.accessoryId,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Empty helper
  static GarmentAccessoryModel empty() {
    return const GarmentAccessoryModel(
      id: '',
      garmentId: '',
      accessoryId: '',
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
       'Id': id,
      'GarmentId': garmentId,
      'AccessoryId': accessoryId,
      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }

  factory GarmentAccessoryModel.fromJson(Map<String, dynamic> json) {
  return GarmentAccessoryModel(
    id: json['Id'] ?? '',
    garmentId: json['GarmentId'] ?? '',
    accessoryId: json['AccessoryId'] ?? '',
    createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}

  /// Create model from Firestore document
  factory GarmentAccessoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    if (data == null) return GarmentAccessoryModel.empty();

    return GarmentAccessoryModel(
      id: document.id,
      garmentId: data['GarmentId'] ?? '',
      accessoryId: data['AccessoryId'] ?? '',
      createdAt: data['CreatedAt'] != null
          ? (data['CreatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['UpdatedAt'] != null
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// CopyWith
  GarmentAccessoryModel copyWith({
    String? id,
    String? garmentId,
    String? accessoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentAccessoryModel(
      id: id ?? this.id,
      garmentId: garmentId ?? this.garmentId,
      accessoryId: accessoryId ?? this.accessoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GarmentAccessoryModel(id: $id, garmentId: $garmentId, accessoryId: $accessoryId)';
  }
}