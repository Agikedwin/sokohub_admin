import 'package:cloud_firestore/cloud_firestore.dart';
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
  AppRole role;

  DateTime? createdAt;
  DateTime? updatedAt;

  bool isProfileActive;
  bool isEmailVerified;
  //VerificationStatus verificationStatus;

  String deviceToken;

  final List<AddressModel>? addresses;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.email,
    
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
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
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      //'FullName': fullName,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'IsEmailVerified': isEmailVerified,
      'IsProfileActive': isProfileActive,
      //'DeviceToken': deviceToken,
     // 'VerificationStatus': verificationStatus.name,
     // 'CreatedAt': createdAt,
      'UpdatedAt': DateTime.now(),
    };
  }

  // Factory method to create UserModel from Firestore document snapshot
  factory UserModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel.fromJson(doc.id, data);
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
  factory UserModel.fromJson(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
      lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
      //fullName: data.containsKey('FullName') ? data['FullName'] ?? '' : '',
      email: data.containsKey('Email') ? data['Email'] ?? '' : '',
      phoneNumber: data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
      profilePicture: data.containsKey('ProfilePicture') ? data['ProfilePicture'] ?? '' : '',
      role: data.containsKey('Role')
          ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString()
          ? AppRole.admin
          : AppRole.user
          : AppRole.user, 
      createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      deviceToken: data.containsKey('DeviceToken') ? data['DeviceToken'] ?? '' : '',
      isEmailVerified: data.containsKey('IsEmailVerified') ? data['IsEmailVerified'] ?? false : false,
      isProfileActive: data.containsKey('IsProfileActive') ? data['IsProfileActive'] ?? false : false,
     // verificationStatus: data.containsKey('VerificationStatus')
     //     ? _mapVerificationStringToEnum(data['VerificationStatus'] ?? '')
      //    : VerificationStatus.pending,
    );
  }
  /* 
  // Utility to map a role string to the Roles enum
  static VerificationStatus _mapVerificationStringToEnum(String verification) {
    switch (verification) {
      case 'pending':
        return VerificationStatus.pending;
      case 'approved':
        return VerificationStatus.approved;
      case 'rejected':
        return VerificationStatus.rejected;
      case 'submitted':
        return VerificationStatus.submitted;
      case 'underReview':
        return VerificationStatus.underReview;
      default:
        return VerificationStatus.unknown;
    }
  } */
}