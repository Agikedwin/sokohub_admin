import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeGarmentModel {
  final String? id;
  final String clientItemId;
  final String clientId;
  final String employeeId;

  const EmployeeGarmentModel({
     this.id,
    required this.clientItemId,
    required this.clientId,
    required this.employeeId,
  });

  /// Empty model
  factory EmployeeGarmentModel.empty() {
    return const EmployeeGarmentModel(
      id: '',
      clientItemId: '',
      clientId: '',
      employeeId: '',
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ClientItemId': clientItemId,
      'ClientId': clientId,
      'EmployeeId': employeeId,
    };
  }

  /// Create model from JSON
  factory EmployeeGarmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return EmployeeGarmentModel(
      id: json['Id'] ?? '',
      clientItemId: json['ClientItemId'] ?? '',
      clientId: json['ClientId'] ?? '',
      employeeId: json['EmployeeId'] ?? '',
    );
  }

  /// Create model from Firestore snapshot
  factory EmployeeGarmentModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (!document.exists || document.data() == null) {
      return EmployeeGarmentModel.empty();
    }

    final data = document.data()!;

    return EmployeeGarmentModel(
      id: data['Id'] ?? document.id,
      clientItemId: data['ClientItemId'] ?? '',
      clientId: data['ClientId'] ?? '',
      employeeId: data['EmployeeId'] ?? '',
    );
  }

  /// Copy with
  EmployeeGarmentModel copyWith({
    String? id,
    String? clientItemId,
    String? clientId,
    String? employeeId,
  }) {
    return EmployeeGarmentModel(
      id: id ?? this.id,
      clientItemId: clientItemId ?? this.clientItemId,
      clientId: clientId ?? this.clientId,
      employeeId: employeeId ?? this.employeeId,
    );
  }
}