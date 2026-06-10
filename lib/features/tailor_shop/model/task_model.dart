import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class TaskModel {
   String? id;
   String name;
   double cost;
   double duration;
  DateTime? createdAt;
  DateTime? updatedAt;

   TaskModel({
    this.id,
    required this.name,
    required this.cost,
    required this.duration,
    this.createdAt,
    this.updatedAt
  });

  /// Empty model
  factory TaskModel.empty() {
    return  TaskModel(
      id: '',
      name: '',
      cost: 0.0,
      duration: 0.0,
      createdAt:  null
    );
  }

  String get formattedDate => TFormatter.formatDate(createdAt);
   String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Cost': cost,
      'Duration': duration,
      'CreatedAt':  createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }

  /// Create model from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['Id'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      cost: (json['Cost'] as num?)?.toDouble() ?? 0.0,
      duration: (json['Duration'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['CreatedAt'] != null
        ? (json['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: json['UpdatedAt'] != null
        ? (json['UpdatedAt'] as Timestamp).toDate()
        : null,
    );
  }

  /// Create model from Firestore snapshot
  factory TaskModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (!document.exists || document.data() == null) {
      return TaskModel.empty();
    }

    final data = document.data()!;

    return TaskModel(
      id:  document.id,
      name: data['Name'] as String? ?? '',
      cost: (data['Cost'] as num?)?.toDouble() ?? 0.0,
      duration: (data['Duration'] as num?)?.toDouble() ?? 0.0,
      createdAt: data['CreatedAt'] != null
        ? (data['CreatedAt'] as Timestamp).toDate()
        : null,
    updatedAt: data['UpdatedAt'] != null
        ? (data['UpdatedAt'] as Timestamp).toDate()
        : null,
    );
  }

  /// Copy with
  TaskModel copyWith({
    String? id,
    String? name,
    double? cost,
    double? duration,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      duration: duration ?? this.duration,
    );
  }
}