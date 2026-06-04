import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class ClientSelectionAttributesModel {
  final String id;
  final String userId;

  final OrderStatus? status;
   UserModel? client;
   List<UserModel> tailorsAssigned;
   GarmentModel garment;
   CartItemModel clientOrder;
   MaterialModel material;
   List<AccessoryModel> accessories;
   List<MeasurementModel> measurements;

  final DateTime orderDate;
  final String paymentMethod;
  final DateTime? deliveryDate;
  final String orderId;
  final String? description;

   ClientSelectionAttributesModel({
    required this.id,
    required this.userId,
    this.status,
    required this.client ,
    this.description,
    required this.tailorsAssigned,
    required this.garment,
    required this.clientOrder,
    required this.material,
    required this.accessories,
    required this.measurements,
    required this.orderDate,
    required this.paymentMethod,
    this.deliveryDate,
    required this.orderId,
  });

  /// Empty Model
  factory ClientSelectionAttributesModel.empty() {
    return ClientSelectionAttributesModel(
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
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status?.name,
      'Client': client!.toJson(),
      'Description': description,
      'TailorsAssigned':
          tailorsAssigned.map((tailor) => tailor.toJson()).toList(),
      'Garment': garment.toJson(),
      'ClientOrder': clientOrder.toJson(),
      'Material': material.toJson(),
      'Accessories':
          accessories.map((accessory) => accessory.toJson()).toList(),
      'Measurements':
          measurements.map((measurement) => measurement.toJson()).toList(),
      'OrderDate': Timestamp.fromDate(orderDate),
      'PaymentMethod': paymentMethod,
      'DeliveryDate':
          deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
      'OrderId': orderId,
    };
  }

  /// From JSON
  factory ClientSelectionAttributesModel.fromJson(
      Map<String, dynamic> data) {
    return ClientSelectionAttributesModel(
      id: data['Id'] ?? '',
      userId: data['UserId'] ?? '',
      status: data['Status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.name == data['Status'],
              orElse: () => OrderStatus.processing,
            )
          : OrderStatus.processing,
      client: UserModel.fromDocSnapshot(data['Client'] ?? {}),
      tailorsAssigned: (data['TailorsAssigned'] as List<dynamic>? ?? [])
          .map((e) => UserModel.fromDocSnapshot(e))
          .toList(),
      garment: GarmentModel.fromSnapshot(data['Garment'] ?? {}),
      clientOrder: CartItemModel.fromJson(data['ClientOrder'] ?? {}),
      material: MaterialModel.fromSnapshot(data['Material'] ?? {}),
      accessories: (data['Accessories'] as List<dynamic>? ?? [])
          .map((e) => AccessoryModel.fromSnapshot(e))
          .toList(),
      measurements: (data['Measurements'] as List<dynamic>? ?? [])
          .map((e) => MeasurementModel.fromSnapshot(e))
          .toList(),
      orderDate: data['OrderDate'] != null
          ? (data['OrderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data['PaymentMethod'] ?? '',
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      orderId: data['OrderId'] ?? '',
      description: data['description'] ?? ''
    );
  }

  /// From Firestore Snapshot
  factory ClientSelectionAttributesModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return ClientSelectionAttributesModel.empty();
    }

    return ClientSelectionAttributesModel.fromJson(document.data()!);
  }
}