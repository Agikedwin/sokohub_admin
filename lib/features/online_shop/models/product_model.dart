 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_attribute_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_variation_model.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';


class ProductModel {
  String? id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  List<String> images;
  String? productType;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.soldQuantity = 0,
    this.brand,
    this.date,
    required this.images,
    required this.salePrice,
    this.isFeatured,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '', images: [], salePrice: 0.0);

 String get formattedDate => TFormatter.formatDate(date);
  // String get formattedUpdatedAtdate => TFormatter.formatDate(updatedAt);
  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
  return {
    'SKU': sku ?? '',
    'Title': title ?? '',
    'Stock': stock ?? 0,
    'Price': price ?? 0.0,
    'SoldQuantity': soldQuantity ?? 0,
    'Images': images ?? [],
    'Thumbnail': thumbnail ?? '',
    'SalePrice': salePrice ?? 0.0,
    'IsFeatured': isFeatured ?? true,
    'Brand': brand != null ? brand!.toJson() : {},
    'Description': description ?? '',
    'ProductType': productType ?? '',
    'Date': Timestamp.now(),

    'ProductAttributes': productAttributes != null
        ? productAttributes!.map((e) => e.toJson()).toList()
        : [],

    'ProductVariations': productVariations != null
        ? productVariations!.map((e) => e.toJson()).toList()
        : [],
  };
}

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0: 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand'], '') : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      date: data['Date'] != null
    ? (data['Date'] as Timestamp).toDate()
    : null,
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList()
          : [],
    );
  }

  /// Map Json oriented Query Snapshot to Model
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'] ?? '',
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
       soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0: 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand'], '') : null,
      images: data['Images'] != null ? List<String>.from(data['Images'], ) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList()
          : [],
    );
  }


    /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;    

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
       soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0: 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand'], '') : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      date: data['Date'] != null
    ? (data['Date'] as Timestamp).toDate()
    : null,
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList()
          : [],
    );
  }
} 