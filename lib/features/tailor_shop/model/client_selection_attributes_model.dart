import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';

class ClientSelectionAttributesModel {
  String id;
  String userId;
  OrderStatus? status;
  UserModel? client;
  List<UserModel>? tailorsAssigned;
  GarmentModel garment;
  CartItemModel clientOrder;
  MaterialModel material;
  List<AccessoryModel> accessories;
  List<MeasurementModel> measurements;
  DateTime? orderDate;
  String paymentMethod;
  DateTime? deliveryDate;
  String orderId;
  String? description;

  ClientSelectionAttributesModel({
    required this.id,
    required this.userId,
    this.status,
    this.client,
    this.description,
     this.tailorsAssigned,
    required this.garment,
    required this.clientOrder,
    required this.material,
    required this.accessories,
    required this.measurements,
     this.orderDate,
    required this.paymentMethod,
    this.deliveryDate,
    required this.orderId,
  });
String get formattedDate => TFormatter.formatDate(orderDate);
 String get formattedUpdatedAtdate => TFormatter.formatDate(deliveryDate);
  /// Empty helper
  static ClientSelectionAttributesModel empty() =>
      ClientSelectionAttributesModel(
        id: '',
        userId: '',
        status: OrderStatus.processing,
        client: UserModel.empty(),
        description: '',
        tailorsAssigned: [],
        garment: GarmentModel.empty(),
        clientOrder: CartItemModel.empty(),
        material: MaterialModel.empty(),
        accessories: [],
        measurements: [],
        orderDate: DateTime.now(),
        paymentMethod: '',
        deliveryDate: null,
        orderId: '',
      );

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status?.name,
      'Client': client?.toJson(),
      'Description': description,
      /* 'TailorsAssigned':
          tailorsAssigned.map((tailor) => tailor.toJson()).toList(), */
      'Garment': garment.toJson(),
      'ClientOrder': clientOrder.toJson(),
      'Material': material.toJson(),
      'Accessories':
          accessories.map((accessory) => accessory.toJson()).toList(),
      'Measurements':
          measurements.map((measurement) => measurement.toJson()).toList(),
      
      'PaymentMethod': paymentMethod,
      'DeliveryDate':
          deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
      'OrderId': orderId,
    };
  }

  /// Create model from JSON
  /// Create model from JSON
factory ClientSelectionAttributesModel.fromJson(
  Map<String, dynamic> json, String id
) {
  return ClientSelectionAttributesModel(
    id: id,
    userId: json['UserId'] ?? '',
    status: json['Status'] != null
        ? OrderStatus.values.firstWhere(
            (e) => e.name == json['Status'],
            orElse: () => OrderStatus.processing,
          )
        : OrderStatus.processing,
    client: json['Client'] != null
        ? UserModel.fromJson(json['id'],json['Client'])
        : UserModel.empty(),
    
    garment: json['Garment'] != null
        ? GarmentModel.fromJson(json['Garment'])
        : GarmentModel.empty(),
    clientOrder: json['ClientOrder'] != null
        ? CartItemModel.fromJson(json['ClientOrder'])
        : CartItemModel.empty(),
    material: json['Material'] != null
        ? MaterialModel.fromJson(json['Material'])
        : MaterialModel.empty(),
    accessories: (json['Accessories'] as List<dynamic>? ?? [])
        .map((e) => AccessoryModel.fromJson(e))
        .toList(),
    measurements: (json['Measurements'] as List<dynamic>? ?? [])
        .map((e) => MeasurementModel.fromJson(e))
        .toList(),
   
    paymentMethod: json['PaymentMethod'] ?? '',
   
    orderId: json['OrderId'] ?? '',
    description: json['Description'] ?? '',
  );
}

/// Create model from Firestore snapshot
factory ClientSelectionAttributesModel.fromSnapshot(
  DocumentSnapshot<Map<String, dynamic>> document,
) {
  try {
    final data = document.data();

    if (data == null) {
      debugPrint(
        '[ClientSelectionAttributesModel] Document ${document.id} has null data',
      );
      return ClientSelectionAttributesModel.empty();
    }

    return ClientSelectionAttributesModel(
      id:  document.id,
      userId: data['UserId']?.toString() ?? '',

      
      client: () {
        try {
          final raw = data['Client'];

          if (raw == null) {
            debugPrint('[ClientSelectionAttributesModel] Client is null');
            return UserModel.empty();
          }

          return UserModel.fromJson(raw['Id'] ?? '', raw);
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] Client parsing error: $e',
          );
          return UserModel.empty();
        }
      }(),

      tailorsAssigned: () {
        try {
          final list = data['TailorsAssigned'];

          if (list is! List) {
            debugPrint(
              '[ClientSelectionAttributesModel] TailorsAssigned is not a List: $list',
            );
            return <UserModel>[];
          }

          return list.map<UserModel>((e) {
            try {
              return UserModel.fromJson('',e);
            } catch (e) {
              debugPrint(
                '[ClientSelectionAttributesModel] Tailor item error: $e | value: $e',
              );
              return UserModel.empty();
            }
          }).toList();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] TailorsAssigned parsing error: $e',
          );
          return <UserModel>[];
        }
      }(),

      garment: () {
        try {
          final raw = data['Garment'];
          return raw != null
              ? GarmentModel.fromJson(raw)
              : GarmentModel.empty();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] Garment parsing error: $e',
          );
          return GarmentModel.empty();
        }
      }(),

      clientOrder: () {
        try {
          final raw = data['ClientOrder'];
          return raw != null
              ? CartItemModel.fromJson(raw)
              : CartItemModel.empty();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] ClientOrder error: $e',
          );
          return CartItemModel.empty();
        }
      }(),

      material: () {
        try {
          final raw = data['Material'];
          return raw != null
              ? MaterialModel.fromJson(raw)
              : MaterialModel.empty();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] Material parsing error: $e',
          );
          return MaterialModel.empty();
        }
      }(),

      accessories: () {
        try {
          final list = data['Accessories'];

          if (list is! List) {
            debugPrint(
              '[ClientSelectionAttributesModel] Accessories is not a List: $list',
            );
            return <AccessoryModel>[];
          }

          return list.map((e) {
            try {
              return AccessoryModel.fromJson(e);
            } catch (e) {
              debugPrint(
                '[ClientSelectionAttributesModel] Accessory item error: $e | value: $e',
              );
              return AccessoryModel.empty();
            }
          }).toList();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] Accessories parsing error: $e',
          );
          return <AccessoryModel>[];
        }
      }(),

      measurements: () {
        try {
          final list = data['Measurements'];

          if (list is! List) {
            debugPrint(
              '[ClientSelectionAttributesModel] Measurements is not a List: $list',
            );
            return <MeasurementModel>[];
          }

          return list.map((e) {
            try {
              return MeasurementModel.fromJson(e);
            } catch (e) {
              debugPrint(
                '[ClientSelectionAttributesModel] Measurement item error: $e | value: $e',
              );
              return MeasurementModel.empty();
            }
          }).toList();
        } catch (e) {
          debugPrint(
            '[ClientSelectionAttributesModel] Measurements parsing error: $e',
          );
          return <MeasurementModel>[];
        }
      }(),

      paymentMethod: data['PaymentMethod']?.toString() ?? '',
      orderId: data['OrderId']?.toString() ?? '',
      description: data['Description']?.toString() ?? '',
    );
  } catch (e, stack) {
    debugPrint(
      '[ClientSelectionAttributesModel] FATAL ERROR: $e\n$stack',
    );
    return ClientSelectionAttributesModel.empty();
  }
}

}