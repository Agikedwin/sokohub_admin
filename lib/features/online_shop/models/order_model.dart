import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/online_shop/models/employee_order_assignment_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/address_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;

   OrderStatus? status;

  final double totalAmount;
  final double shippingCost;
  final double taxCost;

  final DateTime orderDate;
  final String paymentMethod;

  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;

  final DateTime? deliveryDate;

  final List<CartItemModel>? items;


  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.docId = '',
    this.userId = '',
    this.status,
    required this.totalAmount,
    this.shippingCost = 0.0,
    this.taxCost = 0.0,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
    this.shippingAddress,
    this.billingAddress,
    this.deliveryDate,
    this.items,
    this.billingAddressSameAsShipping = true,
  });

  /// Formatted Dates
  String get formatedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formatedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  /// Order Status Text
  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';

      case OrderStatus.shipped:
        return 'Shipment on the way';

      case OrderStatus.processing:
        return 'Processing';

      default:
        return 'Pending';
    }
  }

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
      'id': id,
      'DocId': docId,
      'UserId': userId,
      'Status': status?.name,
      'TotalAmount': totalAmount,
      'ShippingCost': shippingCost,
      'TaxCost': taxCost,
      'OrderDate': Timestamp.fromDate(orderDate),
      'PaymentMethod': paymentMethod,
      'ShippingAddress': shippingAddress?.toJson(),
      'BillingAddress': billingAddress?.toJson(),
      'BillingAddressSameAsShipping': billingAddressSameAsShipping,
      'DeliveryDate':
          deliveryDate != null ? Timestamp.fromDate(deliveryDate!) : null,
      'Items': items?.map((item) => item.toJson()).toList() ?? [],
    };
  }

  /// From Firestore DocumentSnapshot
  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return OrderModel.empty();

    final data = document.data()!;

    return OrderModel(
      docId : data['docId'] ?? document.id,
      id: data['id'] ?? '',
      userId: data['UserId'] ?? '',
      status: data.containsKey('Status') ? OrderStatus.values.firstWhere(
              (e) => e.toString() == data['Status']) : OrderStatus.processing,
      totalAmount:
          double.tryParse((data['TotalAmount'] ?? 0.0).toString()) ?? 0.0,
      shippingCost:
          double.tryParse((data['ShippingCost'] ?? 0.0).toString()) ?? 0.0,
      taxCost: double.tryParse((data['TaxCost'] ?? 0.0).toString()) ?? 0.0,
      orderDate: data['OrderDate'] != null
          ? (data['OrderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data['PaymentMethod'] ?? '',
      shippingAddress: data['ShippingAddress'] != null
          ? AddressModel.fromJson(
              data['ShippingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddress: data['BillingAddress'] != null
          ? AddressModel.fromJson(
              data['BillingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddressSameAsShipping:
          data['BillingAddressSameAsShipping'] ?? true,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map(
                (itemData) => CartItemModel.fromJson(
                  itemData as Map<String, dynamic>,
                ),
              )
              .toList()
          : [],
         
    );
  }

  /// From JSON
  factory OrderModel.fromJson(Map<String, dynamic> data) {
    return OrderModel(
      id: data['id'] ?? '',
      docId: data['DocId'] ?? '',
      userId: data['UserId'] ?? '',
      status: data['Status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.name == data['Status'],
              orElse: () => OrderStatus.processing,
            )
          : OrderStatus.processing,
      totalAmount:
          double.tryParse((data['TotalAmount'] ?? 0.0).toString()) ?? 0.0,
      shippingCost:
          double.tryParse((data['ShippingCost'] ?? 0.0).toString()) ?? 0.0,
      taxCost: double.tryParse((data['TaxCost'] ?? 0.0).toString()) ?? 0.0,
      orderDate: data['OrderDate'] is Timestamp
          ? (data['OrderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data['PaymentMethod'] ?? '',
      shippingAddress: data['ShippingAddress'] != null
          ? AddressModel.fromJson(
              data['ShippingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddress: data['BillingAddress'] != null
          ? AddressModel.fromJson(
              data['BillingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddressSameAsShipping:
          data['BillingAddressSameAsShipping'] ?? true,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map(
                (itemData) => CartItemModel.fromJson(
                  itemData as Map<String, dynamic>,
                ),
              )
              .toList()
          : [],
      
    );
  }

  /// From QuerySnapshot
  factory OrderModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return OrderModel(
      id: document.id,
      docId: data['DocId'] ?? '',
      userId: data['UserId'] ?? '',
      status: data['Status'] != null
          ? OrderStatus.values.firstWhere(
              (e) => e.name == data['Status'],
              orElse: () => OrderStatus.processing,
            )
          : OrderStatus.processing,
      totalAmount:
          double.tryParse((data['TotalAmount'] ?? 0.0).toString()) ?? 0.0,
      shippingCost:
          double.tryParse((data['ShippingCost'] ?? 0.0).toString()) ?? 0.0,
      taxCost: double.tryParse((data['TaxCost'] ?? 0.0).toString()) ?? 0.0,
      orderDate: data['OrderDate'] != null
          ? (data['OrderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data['PaymentMethod'] ?? '',
      shippingAddress: data['ShippingAddress'] != null
          ? AddressModel.fromJson(
              data['ShippingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddress: data['BillingAddress'] != null
          ? AddressModel.fromJson(
              data['BillingAddress'] as Map<String, dynamic>,
            )
          : null,
      billingAddressSameAsShipping:
          data['BillingAddressSameAsShipping'] ?? true,
      deliveryDate: data['DeliveryDate'] != null
          ? (data['DeliveryDate'] as Timestamp).toDate()
          : null,
      items: data['Items'] != null
          ? (data['Items'] as List<dynamic>)
              .map(
                (itemData) => CartItemModel.fromJson(
                  itemData as Map<String, dynamic>,
                ),
              )
              .toList()
          : [],

    
    );
  }
}
