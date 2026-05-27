import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing user assignment data.
class EmployeeOrderAssignmentModel {
  String  id;
  String orderId;
  String userId;
  String? fullName;
  DateTime? createdAt;
  DateTime? updatedAt;

  /// Constructor for EmployeeOrderAssignmentModel.
  EmployeeOrderAssignmentModel({
    required this.id,
    required this.orderId,
    required this.userId,
    this.fullName,
    this.createdAt,
    this.updatedAt,
  });

  /// Static function to create an empty model.
  static EmployeeOrderAssignmentModel empty() => EmployeeOrderAssignmentModel(
        id: '',
        orderId: '',
        userId: '',
        fullName: '',
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'OrderId': orderId,
      'UserId': userId,
      'FullName' :fullName,
      'CreatedAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'UpdatedAt': FieldValue.serverTimestamp(),
    };
  }

  /// Factory method to create EmployeeOrderAssignmentModel from Firestore document snapshot
  factory EmployeeOrderAssignmentModel.fromDocSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    if (data == null || data.isEmpty) {
      return EmployeeOrderAssignmentModel.empty();
    }

    return EmployeeOrderAssignmentModel.fromJson(doc.id, data);
  }

  /// Static method to create an EmployeeOrderAssignmentModel from QuerySnapshot
  static EmployeeOrderAssignmentModel fromQuerySnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data != null && data.isNotEmpty) {
      return EmployeeOrderAssignmentModel.fromJson(doc.id, data);
    }
    return EmployeeOrderAssignmentModel.empty();
  }

  /// Factory method to create an EmployeeOrderAssignmentModel from JSON.
  factory EmployeeOrderAssignmentModel.fromJson(
    String id,
    Map<String, dynamic> data,
  ) {
   
    return EmployeeOrderAssignmentModel(
      id: id,
      orderId: data['OrderId'] ?? '',
      userId: data['UserId'] ?? '',
      fullName: data['FullName'],
      createdAt: data['CreatedAt'] != null
          ? (data['CreatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['UpdatedAt'] != null
          ? (data['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}