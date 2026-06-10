import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class GarmentTasksModel {
  final String id;
  final String garmentId;
  final String taskId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const GarmentTasksModel({
    required this.id,
    required this.garmentId,
    required this.taskId,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Empty helper
  static GarmentTasksModel empty() {
    return const GarmentTasksModel(
      id: '',
      garmentId: '',
      taskId: '',
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
       'Id': id,
      'GarmentId': garmentId,
      'TaskId': taskId,
      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }

  factory GarmentTasksModel.fromJson(Map<String, dynamic> json) {
  return GarmentTasksModel(
    id: json['Id'] ?? '',
    garmentId: json['GarmentId'] ?? '',
    taskId: json['TaskId'] ?? '',
    createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
  );
}

  /// Create model from Firestore document
  factory GarmentTasksModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    if (data == null) return GarmentTasksModel.empty();

    return GarmentTasksModel(
      id: document.id,
      garmentId: data['GarmentId'] ?? '',
      taskId: data['TaskId'] ?? '',
      createdAt: data['CreatedAt'] != null
          ? (data['CreatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['UpdatedAt'] != null
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// CopyWith
  GarmentTasksModel copyWith({
    String? id,
    String? garmentId,
    String? taskId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GarmentTasksModel(
      id: id ?? this.id,
      garmentId: garmentId ?? this.garmentId,
      taskId: taskId ?? this.taskId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GarmentTasksModel(id: $id, garmentId: $garmentId, taskId: $taskId)';
  }
}