import 'package:cloud_firestore/cloud_firestore.dart';

class TrackingNoteModel {
  final String? note;
  final DateTime? createdAt;

  const TrackingNoteModel({
     this.note,
     this.createdAt,
  });

  /// Empty model
  factory TrackingNoteModel.empty() {
    return TrackingNoteModel(
      note: '',
      createdAt: DateTime.now(),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Note': note,
       'CreatedAt': createdAt ?? DateTime.now(),
    };
  }

  /// Create from JSON
  factory TrackingNoteModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TrackingNoteModel(
      note: json['Note'] as String? ?? '',
      createdAt: json['CreatedAt'] != null
          ? (json['CreatedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  /// Create from Firestore DocumentSnapshot
  factory TrackingNoteModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (!document.exists || document.data() == null) {
      return TrackingNoteModel.empty();
    }

    return TrackingNoteModel.fromJson(document.data()!);
  }

  /// CopyWith
  TrackingNoteModel copyWith({
    String? note,
    DateTime? createdAt,
  }) {
    return TrackingNoteModel(
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}