import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

import 'address_model.dart';

/// Model class representing user data.
class UserModel {
  final String id;
  //String fullName;
  String firstName;
  String lastName;
  String email;
  String username;
  String phoneNumber;
  String profilePicture;
  String role;

  DateTime? createdAt;
  DateTime? updatedAt;

  bool isProfileActive;
  bool isEmailVerified;
  //VerificationStatus verificationStatus;

  String deviceToken;

   List<AddressModel>? addresses;
  List<OrderModel>? orders;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.email,
    
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.createdAt,
    this.updatedAt,
    this.deviceToken = '',
    required this.isEmailVerified,
    required this.isProfileActive,
   // this.verificationStatus = VerificationStatus.unknown,
    this.addresses,
  });

  /// Helper methods

  String get fullName => '$firstName $lastName';
  String get fullNamePhone => '$firstName $lastName($phoneNumber)';
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
      id: '',
      email: '',
      firstName: '',
      lastName: '',
      username: '',
      phoneNumber: '',
      profilePicture: '',
      createdAt: null,
      updatedAt: null,
      deviceToken: '',
      isEmailVerified: false,
      isProfileActive: false,
      addresses: null,
    );// Default createdAt to current time

  /// Convert model to JSON structure for storing data in Firebase.
 /// Convert model to JSON structure for storing data in Firebase.
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'username': username,
    'phoneNumber': phoneNumber,
    'profilePicture': profilePicture,
    'role': role,
    'isEmailVerified': isEmailVerified,
    'isProfileActive': isProfileActive,
    'deviceToken': deviceToken,
    'createdAt': createdAt != null
        ? Timestamp.fromDate(createdAt!)
        :  null,
    'updatedAt': createdAt != null
        ? Timestamp.fromDate(createdAt!)
        :  null,
    'addresses': addresses?.map((e) => e.toJson()).toList() ?? [],
  };
}

  // Factory method to create UserModel from Firestore document snapshot
  /// Factory method to create UserModel from Firestore document snapshot
factory UserModel.fromDocSnapshot(
  DocumentSnapshot<Map<String, dynamic>> doc,
) {
  final data = doc.data();

  if (data == null || data.isEmpty) {
    return UserModel.empty();
  }

  return UserModel(
    id: doc.id,

    firstName: data['firstName'] ?? '',
    lastName: data['lastName'] ?? '',
    email: data['email'] ?? '',
    username: data['username'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    profilePicture: data['profilePicture'] ?? '',
    deviceToken: data['deviceToken'] ?? '',

    role: data['role'] == AppRole.admin.name.toString()
        ? AppRole.admin.toString()
        : data['role'],

    isEmailVerified:
        data['isEmailVerified'] ?? false,

    isProfileActive:
        data['isProfileActive'] ?? false,

    createdAt: data['createdAt'] != null
        ? (data['createdAt'] as Timestamp).toDate()
        : null,

    updatedAt: data['updatedAt'] != null
        ? (data['updatedAt'] as Timestamp).toDate()
        : null,

    addresses: data['addresses'] != null
        ? (data['addresses'] as List)
            .map(
              (e) => AddressModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList()
        : [],
  );
}

  // Static method to create a list of UserModel from QuerySnapshot (for retrieving multiple users)
  static UserModel fromQuerySnapshot(QueryDocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>;
    if(data.isNotEmpty){
      return UserModel.fromJson(doc.id, data);

    }

    return UserModel.empty();
    
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  /// Factory method to create a UserModel from JSON.
factory UserModel.fromJson(
  String id,
  Map<String, dynamic> data,
) {
  return UserModel(
    id: id ,

    firstName: data['firstName'] ?? '',
    lastName: data['lastName'] ?? '',
    email: data['email'] ?? '',
    username: data['username'] ?? '',
    phoneNumber: data['phoneNumber'] ?? '',
    profilePicture: data['profilePicture'] ?? '',
    deviceToken: data['deviceToken'] ?? '',

    role: data['role'] == AppRole.admin.name.toString()
        ? AppRole.admin.toString()
        : data['role'],

    isEmailVerified:
        data['isEmailVerified'] ?? false,

    isProfileActive:
        data['isProfileActive'] ?? false,

    createdAt: data['createdAt'] != null
        ? (data['createdAt'] as Timestamp).toDate()
        : null,

    updatedAt: data['updatedAt'] != null
        ? (data['updatedAt'] as Timestamp).toDate()
        : null,

    addresses: data['addresses'] != null
        ? (data['addresses'] as List)
            .map(
              (e) => AddressModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList()
        : [],
  );
}
 UserModel copyWith({
  String? id,
  String? email,
  String? firstName,
  String? lastName,
  String? username,
  String? phoneNumber,
  String? profilePicture,
  String? role,
  String? deviceToken,
  bool? isEmailVerified,
  bool? isProfileActive,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    username: username ?? this.username,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    profilePicture: profilePicture ?? this.profilePicture,
    role: role ?? this.role,
    deviceToken: deviceToken ?? this.deviceToken,
    isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    isProfileActive: isProfileActive ?? this.isProfileActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
}