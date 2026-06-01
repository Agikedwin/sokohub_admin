import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class MeasurementModel {
  String id;
  String name;
  String image;
  DateTime? createdAt;
  DateTime? updatedAt;

  MeasurementModel({
    required this.id,
    required this.name,
    required this.image,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

  /// Empty helper Function
  static MeasurementModel empty() => MeasurementModel(
        id: '',
        name: '',
        image: '',
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }



  /// Create CategoryModel from Firebase DocumentSnapshot
 factory MeasurementModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  final data = document.data();

  if (data == null) return MeasurementModel.empty();

  return MeasurementModel(
    id: document.id,
    name: data['Name'] ?? '',
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
  MeasurementModel copyWith({
    String? id,
    String? name,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MeasurementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'MeasurementModel(name: $name)';
  }
}