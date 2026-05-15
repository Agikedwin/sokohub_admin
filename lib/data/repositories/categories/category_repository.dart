import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class CategoryRepository  extends GetxController{

  static CategoryRepository get instance => Get.find();

/// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all categories from Category collection
  
  Future<List<CategoryModel>> getAllCategories() async {
    
    try {
      final snapshot = await _db.collection('Categories').get();

      final result = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      
      return result;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }
  
  /// Get Sub Categories
  /// 
  /// Fuction to save user data to firestore

  Future<String> createCategory(CategoryModel category) async {
    try {
      final data = await _db.collection('Categories').add(category.toJson());
      return  data.id;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }


  Future<void> updateSingleField(Map<String, dynamic> json, String id) async {
    try {
      await _db
          .collection('Users')
          .doc(id)
          .update(json);
   } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  

  /// Fuction to update user data in Firestore

  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      await _db
          .collection('Categories')
          .doc(category.id)
          .update(category.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return CategoryModel.empty();
  }


  /// Upload categories to the cloud Firestore
  
 Future<String> uploadImage(String path, XFile image) async{
  try {
 final  ref = FirebaseStorage.instance.ref(path).child(image.name);
 await ref.putFile(File(image.path));

 final url = await ref.getDownloadURL();
 return url;


 
 } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }


 }

// get sub categories
    Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    
    try {
      final snapshot = await _db.collection('Categories').where('ParentId', isEqualTo: categoryId).get();

      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      
      return list;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> deleteCategory(String categoryId) async {

    try {
      await _db.collection('Categories').doc(categoryId).delete();

    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }
  
}