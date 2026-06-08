import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class GarmentMeasurementModel {
  final String id;
  final String garmentId;
  final String measurementId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GarmentMeasurementModel({
    required this.id,
    required this.garmentId,
    required this.measurementId,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Empty helper
  static GarmentMeasurementModel empty() {
    return const GarmentMeasurementModel(
      id: '',
      garmentId: '',
      measurementId: '',
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
       'Id': id,
      'GarmentId': garmentId,
      'MeasurementId': measurementId,
      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }

  factory GarmentMeasurementModel.fromJson(Map<String, dynamic> json) {
  return GarmentMeasurementModel(
    id: json['Id'] ?? '',
    garmentId: json['GarmentId'] ?? '',
    measurementId: json['MeasurementId'] ?? '',
    createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}

  /// Create model from Firestore document
  factory GarmentMeasurementModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    if (data == null) return GarmentMeasurementModel.empty();

    return GarmentMeasurementModel(
      id: document.id,
      garmentId: data['GarmentId'] ?? '',
      measurementId: data['MeasurementId'] ?? '',
      createdAt: data['CreatedAt'] != null
          ? (data['CreatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['UpdatedAt'] != null
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// CopyWith
  GarmentMeasurementModel copyWith({
    String? id,
    String? garmentId,
    String? measurementId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentMeasurementModel(
      id: id ?? this.id,
      garmentId: garmentId ?? this.garmentId,
      measurementId: measurementId ?? this.measurementId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GarmentAccessoryModel(id: $id, garmentId: $garmentId, measurementId: $measurementId)';
  }
}