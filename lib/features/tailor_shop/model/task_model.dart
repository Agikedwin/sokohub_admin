import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/tracking_notes_model.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class TaskModel {
   String? id;
   String name;
   double cost;
   double duration;
   List<UserModel>? doneBy;
  List<UserModel>? assignedTo;
  String status;
  DateTime? completedAt;
  List<TrackingNoteModel>? trackingNotes;
  DateTime? createdAt;
  DateTime? updatedAt;

   TaskModel({
    this.id,
    required this.name,
    required this.cost,
    required this.duration,
    this.doneBy,
    this.assignedTo,
    this.status = 'Pending',
    this.completedAt,
    this.trackingNotes = const [],
    this.createdAt,
    this.updatedAt,
  });

  /// Empty model
  factory TaskModel.empty() {
    return TaskModel(
      id: '',
      name: '',
      cost: 0.0,
      duration: 0.0,
      doneBy: [],
      assignedTo: [],
      status: 'Pending',
      completedAt: null,
      trackingNotes: [],
      createdAt: null,
      updatedAt: null,
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

      'DoneBy': doneBy?.map((e) => e.toJson()).toList() ?? [],
      'AssignedTo': assignedTo?.map((e) => e.toJson()).toList() ?? [],

      'Status': status,
      'CompletedAt': completedAt,
      'TrackingNotes':
          trackingNotes?.map((e) => e.toJson()).toList() ?? [],

      'CreatedAt': createdAt ?? DateTime.now(),
      'UpdatedAt': updatedAt,
    };
  }



    /// Create model from JSON Tasks Tarcking
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    print('===========================================ssssssssssssssssssssssssssssssssssssssssssssssss');
    print(json);
    return TaskModel(
      id: json['Id'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      cost: (json['Cost'] as num?)?.toDouble() ?? 0.0,
      duration: (json['Duration'] as num?)?.toDouble() ?? 0.0,

      doneBy: (json['DoneBy'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(
                    '',
                    Map<String, dynamic>.from(e),
                  ))
              .toList() ??
          [],

      assignedTo: (json['AssignedTo'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(
                    '',
                    Map<String, dynamic>.from(e),
                  ))
              .toList() ??
          [],

      status: json['Status'] as String? ?? 'Pending',

      completedAt: json['CompletedAt'] != null
          ? (json['CompletedAt'] as Timestamp).toDate()
          : null,

      trackingNotes: (json['TrackingNotes'] as List<dynamic>?)
              ?.map((e) => TrackingNoteModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ))
              .toList() ??
          [],

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