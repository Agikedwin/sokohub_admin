import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

}