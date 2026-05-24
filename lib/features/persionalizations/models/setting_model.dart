import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;
  bool maintenanceMode;

  SettingModel({
     this.id,
     this.taxRate = 0.0,
     this.shippingCost = 0.0,
    this.freeShippingThreshold,
     this.appName = '',
     this.appLogo = '',
    this.maintenanceMode = false,
  });

  /// Empty model
  static SettingModel empty() => SettingModel(
        id: '',
        taxRate: 0.0,
        shippingCost: 0.0,
        freeShippingThreshold: 0.0,
        appName: 'Sokohub',
        appLogo: '',
        maintenanceMode: false,
      );

  /// Convert to JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'TaxRate': taxRate,
      'ShippingCost': shippingCost,
      'FreeShippingThreshold': freeShippingThreshold,
      'AppName': appName,
      'AppLogo': appLogo,
      'MaintenanceMode': maintenanceMode,
    };
  }

  /// From Firestore DocumentSnapshot
  factory SettingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return SettingModel.empty();

    final data = document.data()!;

    return SettingModel(
      id: document.id,
      taxRate: (data['TaxRate'] ?? 0).toDouble(),
      shippingCost: (data['ShippingCost'] ?? 0).toDouble(),
      freeShippingThreshold:
          (data['FreeShippingThreshold'] ?? 0).toDouble(),
      appName: data.containsKey('AppName')  ? data['AppName'] ?? '' : '',
      appLogo: data.containsKey('AppLogo') ? data['AppLogo'] ?? '' : '',
      maintenanceMode: data['MaintenanceMode'] ?? false,
    );
  }

  /// From JSON
  factory SettingModel.fromJson(Map<String, dynamic> data) {
    return SettingModel(
      id: data['id'] ?? '',
      taxRate: (data['TaxRate'] ?? 0).toDouble(),
      shippingCost: (data['ShippingCost'] ?? 0).toDouble(),
      freeShippingThreshold:
          (data['FreeShippingThreshold'] ?? 0).toDouble(),
      appName: data['AppName'] ?? '',
      appLogo: data['AppLogo'] ?? '',
      maintenanceMode: data['MaintenanceMode'] ?? false,
    );
  }

  /// From QuerySnapshot
  factory SettingModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return SettingModel(
      id: document.id,
      taxRate: (data['TaxRate'] ?? 0).toDouble(),
      shippingCost: (data['ShippingCost'] ?? 0).toDouble(),
      freeShippingThreshold:
          (data['FreeShippingThreshold'] ?? 0).toDouble(),
      appName: data['AppName'] ?? '',
      appLogo: data['AppLogo'] ?? '',
      maintenanceMode: data['MaintenanceMode'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Settings(appName: $appName, taxRate: $taxRate, shippingCost: $shippingCost)';
  }
}