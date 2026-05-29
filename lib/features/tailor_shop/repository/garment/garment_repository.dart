import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class GarmentRepository  extends GetxController{

  static GarmentRepository get instance => Get.find();

/// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all Garment from Category collection
  
  Future<List<GarmentModel>> getAllGarments() async {
    
    try {
      final snapshot = await _db.collection('Garments').get();

      final result = snapshot.docs.map((doc) => GarmentModel.fromSnapshot(doc)).toList();
      
      return result;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(e);
      throw 'Some thing went wrong, Please try again';
    }
  }
  
  /// Get Sub Garments
  /// 
  /// Fuction to save user data to firestore

  Future<String> createGarment(GarmentModel material) async {
    try {
      final data = await _db.collection('Garments').add(material.toJson());
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
          .collection('Garments')
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

  Future<GarmentModel> updateGarment(GarmentModel material) async {
    try {
      await _db
          .collection('Garments')
          .doc(material.id)
          .update(material.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return GarmentModel.empty();
  }


  /// Upload Garment to the cloud Firestore
  
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

// get sub Garment
    Future<List<GarmentModel>> getSubGarment(String material) async {
    
    try {
      final snapshot = await _db.collection('Garments').where('ParentId', isEqualTo: material).get();

      final list = snapshot.docs.map((document) => GarmentModel.fromSnapshot(document)).toList();
      
      return list;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> deleteGarment(String materialId) async {

    try {
      await _db.collection('Garments').doc(materialId).delete();

    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }
  
}