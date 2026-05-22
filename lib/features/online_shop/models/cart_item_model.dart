import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    
    this.image,
    required this.quantity,
    required this.variationId,
    required this.brandName,
    this.selectedVariation,
  });

  String get totalAmount => (price * quantity).toStringAsFixed(1);

  /// Empty helper function
  static CartItemModel empty() => CartItemModel(
        productId: '',
        title: '',
        price: 0.0,
        image: '',
        quantity: 0,
        variationId: '',
        brandName: '',
        selectedVariation: {},
      );

  /// Convert model to JSON (for Firebase)
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'BrandName': brandName,
      'SelectedVariation': selectedVariation,
    };
  }

  /// Create model from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'] ?? '',
      title: json['Title'] ?? '',
      price: (json['Price'] ?? 0).toDouble(),
      image: json['Image'],
      quantity: json['Quantity'] ?? 0,
      variationId: json['VariationId'] ?? '',
      brandName: json['BrandName'] ?? '',
      selectedVariation: json['SelectedVariation'] != null
          ? Map<String, String>.from(json['SelectedVariation'])
          : {},
    );
  }

  /// Create model from Firestore snapshot
  factory CartItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CartItemModel(
        productId: data['ProductId'] ?? '',
        title: data['Title'] ?? '',
        price: (data['Price'] ?? 0).toDouble(),
        image: data['Image'],
        quantity: data['Quantity'] ?? 0,
        variationId: data['VariationId'] ?? '',
        brandName: data['BrandName'] ?? '',
        selectedVariation: data['SelectedVariation'] != null
            ? Map<String, String>.from(data['SelectedVariation'])
            : {},
      );
    } else {
      return CartItemModel.empty();
    }
  }
}