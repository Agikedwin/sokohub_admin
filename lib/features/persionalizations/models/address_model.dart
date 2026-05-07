import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatter.dart';

class AddressModel {
  String id;
  String name;
  String phoneNumber;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  Timestamp? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  /// Format phone number
  String get formattedPhoneNo =>
      TFormatter.formatPhoneNumber(phoneNumber);

  /// Empty model
  static AddressModel empty() => AddressModel(
        id: '',
        name: '',
        phoneNumber: '',
        street: '',
        city: '',
        state: '',
        postalCode: '',
        country: '',
      );

  /// Convert to JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': Timestamp.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  /// From Firestore DocumentSnapshot
  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return AddressModel.empty();
    final data = document.data()!;

    return AddressModel(
      id: document.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime:
          data['DateTime'] != null ? data['DateTime'] as Timestamp : null,
      selectedAddress: data['SelectedAddress'] ?? false,
    );
  }

  /// From JSON
  factory AddressModel.fromJson(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'] ?? '',
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime:
          data['DateTime'] != null ? data['DateTime'] as Timestamp : null,
      selectedAddress: data['SelectedAddress'] ?? false,
    );
  }

  /// From QuerySnapshot
  factory AddressModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return AddressModel(
      id: document.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime:
          data['DateTime'] != null ? data['DateTime'] as Timestamp : null,
      selectedAddress: data['SelectedAddress'] ?? false,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}