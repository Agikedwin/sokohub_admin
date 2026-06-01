import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_accessory_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class AccessoryRepository  extends GetxController{

  static AccessoryRepository get instance => Get.find();

/// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all categories from Category collection
  
  Future<List<AccessoryModel>> getAllAccessories() async {
    
    try {
      final snapshot = await _db.collection('Accessories').get();

      final result = snapshot.docs.map((doc) => AccessoryModel.fromSnapshot(doc)).toList();
      
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
  
  /// Get Sub Accessories
  /// 
  /// Fuction to save user data to firestore

  Future<String> createAccessory(AccessoryModel material) async {
    try {
      final data = await _db.collection('Accessories').add(material.toJson());
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

  Future<AccessoryModel> updateAccessory(AccessoryModel material) async {
    try {
      await _db
          .collection('Accessories')
          .doc(material.id)
          .update(material.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return AccessoryModel.empty();
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
    Future<List<GarmentAccessoryModel>> getAllGarmentAccessory(String garmentId) async {
    
    try {
      final snapshot = await _db.collection('GarmentAccessory').where('GarmentId', isEqualTo: garmentId).get();

      final list = snapshot.docs.map((document) => GarmentAccessoryModel.fromSnapshot(document)).toList();
      
      return list;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> deleteAccessory(String id) async {

    try {
      await _db.collection('Accessories').doc(id).delete();

    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }


  Future<List<GarmentAccessoryModel>> getAllccessories() async {
    
    try {
      final snapshot = await _db.collection('Accessories').get();

      final result = snapshot.docs.map((doc) => GarmentAccessoryModel.fromSnapshot(doc)).toList();
      
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
  


  Future<void> deleteGarmentAccessory(String materialId) async {

    try {
      await _db.collection('Accessories').doc(materialId).delete();

    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<String> assignAccessory(GarmentAccessoryModel accessory) async {

    try {
      final data = await _db.collection('GarmentAccessory').add(accessory.toJson());
      return  data.id;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }


  Future<void> deleteAAssociatedccessory(String accessoryId, String garmentId ) async {
    print('deleted $accessoryId  $garmentId');

    
      try {
     final result =  await _db
          .collection('GarmentAccessory').where('AccessoryId', isEqualTo: accessoryId).where('GarmentId', isEqualTo: garmentId).get();
      for(final doc in result.docs){
        await doc.reference.delete();
      }
   
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



  
  
}