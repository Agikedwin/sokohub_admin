import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/online_shop/models/product_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Varibles
  final _db = FirebaseFirestore.instance;


  /// Create product

  Future<String> createProduct(ProductModel product ) async {
    try {
     final result =  await _db.collection('Products').add(product.toJson());
     return result.id;
 
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(e);
      print(trace);
      throw 'Something went wrong, please try again';
    }
  }


  /// Create product

  Future<void> createProductCategory(ProductCategoryModel productCategory ) async {
    try {
      await _db.collection('ProductCategory').add(productCategory.toJson());
 
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
  
      throw 'Something went wrong, please try again';
    }
  }
  /// Get limited featured products
  Future<List<ProductCategoryModel>> getProductCategories(String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId).get();

      return snapshot.docs
          .map((document) => ProductCategoryModel.fromSnapshot(document))
          .toList();

    
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Get all future products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();

      return list;
   
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      print(e);
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Get product by qury
  Future<dynamic> fetchProductsByQuery(Query<Object?> query) async {
    try {
      final querySnapshot = await query.get();

      final List<ProductModel> productList = querySnapshot.docs
          .map((document) => ProductModel.fromQuerySnapshot(document))
          .toList();

      return productList;
   
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
  }


  /// Fuction to update user data in Firestore

  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      await _db
          .collection('Products')
          .doc(product.id)
          .update(product.toJson());
   
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return ProductModel.empty();
  }

  /// Add data to a single field
  Future<void> addImageToProduct(
    String productId,
    String imageUrl,
    String docField,
  ) async {
    try {
      await _db.collection('Products').doc(productId).update({
        docField: FieldValue.arrayUnion([imageUrl]),
      });
   
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<void> updateProductSpecificValue(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection('Products').doc(id).update(data);
      

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  /// Upload Products to the cloud Firestore

  Future<String> uploadImage(String path, XFile? image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image!.name);
      await ref.putFile(File(image!.path));

      final url = await ref.getDownloadURL();
      return url;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForBrands({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final queryDocumentSnapshot = limit == -1
          ? await _db
                .collection('Products')
                .where('Brand.id', isEqualTo: brandId)
                .get()
          : await _db
                .collection('Products')
                .where('Brand.id', isEqualTo: brandId)
                .limit(limit)
                .get();

      final products = queryDocumentSnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
 
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({
    // query all documents where productid matches the provided categortId & fetch limited or unlimited based on the limit
    required String categoryId,
    int limit = -1,
  }) async {
    try {
     // Query to get all documents where categoryId matched the provided categoryId
     QuerySnapshot productCategoryQuery = limit == -1 
     ? await _db.collection('ProductCategory').where('categoryId',isEqualTo: categoryId).get()
     : await _db.collection('ProductCategory').where('categoryId',isEqualTo: categoryId).limit(limit).get();

     // Extract productId from the document
     
     List<String> productIds = productCategoryQuery.docs.map((doc)=> doc['productId'] as String).toList();
  

     // Query to get all documents where the productId is in the list of productId, firled.documentId to query documets in collection
     final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).limit(3).get();

     List<ProductModel> products = productsQuery.docs.map((doc)=> ProductModel.fromSnapshot(doc)).toList();
  
     return products;


    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      throw 'Some thing went wrong, Please try again';
    }
}

/// Get favorite product by qury
  Future<void> deleteProduct(ProductModel product) async {
   try {
    await _db.runTransaction((transaction) async{
      final productRef = _db.collection('Products').doc(product.id);
      final productSnap = await transaction.get(productRef);

      if(productSnap.exists){
        throw Exception('Product not found');
      }
      //Fetch ProductCategory
      final productCategoriesSnapshot = await _db.collection('ProductCategory').where('productId', isEqualTo: product.id).get();
      final productCategories = productCategoriesSnapshot.docs.map((e) => ProductCategoryModel.fromSnapshot(e));

      if(productCategories.isNotEmpty){
        for (var productCategory in productCategories){
          transaction.delete(_db.collection('ProductCategory').doc(productCategory.id));
        }
      }
       transaction.delete(productRef);

    });
     
     
    
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e, trace) {
      throw 'Some thing went wrong, Please try again';
    }

  }


  /// Get favorite product by qury
  Future<List<ProductModel>> getFavoritesProducts(List<String> productIds) async {
    try {
      
        final snapShot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

        if(snapShot.docs.isEmpty){
          return [ProductModel.empty()];
        }

     return  snapShot.docs.map((querySnapShot )=> ProductModel.fromSnapshot(querySnapShot)).toList();

  
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
  }
}
