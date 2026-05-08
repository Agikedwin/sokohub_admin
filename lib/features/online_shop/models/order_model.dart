import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/address_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';


class OrderModel {
  String id;
  String userId;
  OrderStatus? status;
  double totalAmount;
  DateTime orderDate;
  String paymentMethod;
  AddressModel? address;
  DateTime? deliveryDate;
  List<CartItemModel>? items;

  OrderModel({
   required this.id,
    required this.userId,
     this.status,
    required this.totalAmount,
    required this.orderDate,
     this.paymentMethod = 'Paypal',
    this.address,
    this.deliveryDate,
    this.items,
  });

String get formatedOrderDate => THelperFunctions.getFormattedDate(orderDate);

String get formatedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!) : '';

String get orderStatusText => status == OrderStatus.delivered.toString()
? 'Delivered'
: status == OrderStatus.shipped.toString()
? 'Shipment on the way'
: 'Processing';
  /// Empty constructor
  static OrderModel empty() => OrderModel(
        id: '',
        userId: '',
        totalAmount: 0.0,
        orderDate: DateTime.now(),
        paymentMethod: '',
        items: [],
      );

  /// Convert to JSON for Firebase
  Map<String, dynamic> toJson() {
    return {
      id: id,
      'UserId': userId,
      'Status': status.toString(),
      'TotalAmount': totalAmount,
      'OrderDate': orderDate,
      'PaymentMethod': paymentMethod,
      'Address': address?.toJson(),
      'DeliveryDate': deliveryDate,
      'Items': items!.map((item) => item.toJson()).toList(),
    };
  }

  /// From Firestore DocumentSnapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return OrderModel.empty();
    final data = document.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: data['UserId'] ?? '',
     // status: OrderStatus.values.firstWhere((e) => e.toString() == data['Status']).toString(),
      totalAmount: double.parse((data['TotalAmount'] ?? 0.0).toString()),
      orderDate: (data['OrderDate'] as Timestamp).toDate(),
      paymentMethod: data['PaymentMethod'] ?? '',
      address: data['Address'] != null ? AddressModel.fromJson(data['Address'] as Map<String, dynamic>) : null,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map((itemData) => CartItemModel.fromJson(itemData as Map<String , dynamic>))
              .toList()
          : [],
    );
  }

  /// From JSON
  factory OrderModel.fromJson(Map<String, dynamic> data) {
    return OrderModel(
      id: data['id'] ?? '',
      userId: data['UserId'] ?? '',
      status: data['Status'] ?? '',
      totalAmount: double.parse((data['TotalAmount'] ?? 0.0).toString()),
      orderDate: data['OrderDate'] ?? '',
      paymentMethod: data['PaymentMethod'] ?? '',
      address: data['Address'] != null ? AddressModel.fromJson(data['Address']) : null,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  /// From QuerySnapshot
  factory OrderModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return OrderModel(
      id: document.id,
      userId: data['UserId'] ?? '',
      status: data['Status'] ?? '',
      totalAmount: double.parse((data['TotalAmount'] ?? 0.0).toString()),
      orderDate: data['OrderDate'] ?? '',
      paymentMethod: data['PaymentMethod'] ?? '',
      address: data['Address'] != null ? AddressModel.fromJson(data['Address']) : null,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}