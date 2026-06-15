import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/tracking_notes_model.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class TaskTrackerModel {
  String? id;
  List<TaskModel> tasks;
  List<UserModel>? doneBy;
  List<UserModel>? assignedTo;
  String status;
  DateTime? completedAt;
  List<TrackingNoteModel>? trackingNotes;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaskTrackerModel({
    this.id,
    required this.tasks,
    this.doneBy,
    this.assignedTo,
    this.status = 'Pending',
    this.completedAt,
    this.trackingNotes = const [],
    this.createdAt,
    this.updatedAt,
  });

  /// Empty model
  factory TaskTrackerModel.empty() {
    return TaskTrackerModel(
      id: '',
      tasks: [],
      doneBy: [],
      assignedTo: [],
      status: 'Pending',
      completedAt: null,
      trackingNotes: [],
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  /// Formatted Dates
  String get formattedCreatedAt =>
      createdAt != null ? TFormatter.formatDate(createdAt!) : '';

  String get formattedUpdatedAt =>
      updatedAt != null ? TFormatter.formatDate(updatedAt!) : '';

  String get formattedCompletedAt =>
      completedAt != null ? TFormatter.formatDate(completedAt!) : '';

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Tasks': tasks.map((e) => e.toJson()).toList(),
      'DoneBy': doneBy?.map((e) => e.toJson()).toList() ?? [],
      'AssignedTo': assignedTo?.map((e) => e.toJson()).toList() ?? [],
      'Status': status,
      'CompletedAt':completedAt ,
      'TrackingNotes': trackingNotes?.map((e) => e.toJson()) ?? [],
      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt':updatedAt,
    };
  }

  /// Create model from JSON
  factory TaskTrackerModel.fromJson(Map<String, dynamic> json) {
    return TaskTrackerModel(
      id: json['Id'] as String?,

      tasks: (json['Tasks'] as List<dynamic>?)
              ?.map(
                (e) => TaskModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],

      doneBy: (json['DoneBy'] as List<dynamic>?)
              ?.map(
                (e) => UserModel.fromJson(
                  '',
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],

      assignedTo: (json['AssignedTo'] as List<dynamic>?)
              ?.map(
                (e) => UserModel.fromJson(
                  '',
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],

      status: json['Status'] as String? ?? 'Pending',

      trackingNotes: (json['TrackingNotes'] as List<dynamic>?)
              ?.map(
                (e) => TrackingNoteModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],

      completedAt: json['CompletedAt'] != null
          ? (json['CompletedAt'] as Timestamp).toDate()
          : null,

      createdAt: json['CreatedAt'] != null
          ? (json['CreatedAt'] as Timestamp).toDate()
          : null,

      updatedAt: json['UpdatedAt'] != null
          ? (json['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// CopyWith
  TaskTrackerModel copyWith({
    String? id,
    List<TaskModel>? tasks,
    List<UserModel>? doneBy,
    List<UserModel>? assignedTo,
    String? status,
    DateTime? completedAt,
    List<TrackingNoteModel>? trackingNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskTrackerModel(
      id: id ?? this.id,
      tasks: tasks ?? this.tasks,
      doneBy: doneBy ?? this.doneBy,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      trackingNotes: trackingNotes ?? this.trackingNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}