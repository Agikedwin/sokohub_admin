import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

/// get all brands from Brands collection
  Future<List<BrandModel>> getAllBrands() async {
   try {
     
     final snapShot = await _db.collection('Brands').get();
     final result  = snapShot.docs.map((brand) => BrandModel.fromSnapshot(brand)).toList();
     return result;

    
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


/// Get brands for BrandCategory

  Future<List<BrandCategoryModel>> getAllBrandForCategory() async {
   try {
     // Query to get all documents where categoryId matched the provided categoryId
     QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').get();

    

     final brandCategories = brandCategoryQuery.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();
     return brandCategories;

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

// Create a new brand documet in the 'Brands' collection
  Future<String> createBrand(BrandModel brand) async {
   try {
     
     final result = await _db.collection('Brands').add(brand.toJson());
     return result.id;

    
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


// Create a new brand documet in the 'BrandCategoryModel' collection
  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
   try {
     
     final result = await _db.collection('BrandCategory').add(brandCategory.toJson());
     return result.id;

    
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


// Update an existing brand documet in the 'Brand' collection
  Future<void> updateBrand(BrandModel brand) async {
   try {
     
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
    
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


// Delete an existing brand documet and its associated brand categories
  Future<void> deleteBrand(BrandModel brand) async {
   try {
    await _db.runTransaction((transaction) async{
      final brandRef = _db.collection('Brands').doc(brand.id);
      final brandSnap = await transaction.get(brandRef);

      if(!brandSnap.exists){
        throw Exception('Brand not found');
      }
      final brandCategoriesSnapshot = await _db.collection('BrandCategory').where('brandId', isEqualTo: brand.id).get();
      final brandCategories = brandCategoriesSnapshot.docs.map((e) => BrandCategoryModel.fromSnapshot(e));

      if(brandCategories.isNotEmpty){
        for (var brandCategory in brandCategories){
          transaction.delete(_db.collection('BrandCategory').doc(brandCategory.id));
        }
      }
       transaction.delete(brandRef);

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

  // Delete a brand category document in the 'BrandCategory' colection
  Future<void> deleteBrandCategory(String  brandCategoryId) async {
   try {
     
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
    
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

  Future<List<BrandCategoryModel>> getCategoriesOfSpecicBrand(String brandId) async {
     try {
     
      final brandCategoryQuery =  await _db.collection('BrandCategory').where('brandId', isEqualTo: brandId).get();
      final brandCategories = brandCategoryQuery.docs.map((doc)=> BrandCategoryModel.fromSnapshot(doc)).toList();
      return brandCategories;
    
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;       
    } catch (e, trace) {
      throw 'Some thing went wrong, Please try again';
    }

  }

  

}