import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_measuremnt_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class MeasurementRepository  extends GetxController{

  static MeasurementRepository get instance => Get.find();

/// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all Measurement from Category collection
  
  Future<List<MeasurementModel>> getAllMeasurements() async {
    
    try {
      final snapshot = await _db.collection('Measurements').get();

      final result = snapshot.docs.map((doc) => MeasurementModel.fromSnapshot(doc)).toList();
      
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
  
  /// Get Sub Measurements
  /// 
  /// Fuction to save user data to firestore

  Future<String> createMeasurement(MeasurementModel material) async {
    try {
      final data = await _db.collection('Measurements').add(material.toJson());
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
          .collection('Measurements')
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

  Future<MeasurementModel> updateMeasurement(MeasurementModel material) async {
    try {
      await _db
          .collection('Measurements')
          .doc(material.id)
          .update(material.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return MeasurementModel.empty();
  }


  /// Upload Measurement to the cloud Firestore
  
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

// get sub Measurement
    Future<List<MeasurementModel>> getSubMeasurement(String measurement) async {
    
    try {
      final snapshot = await _db.collection('GarmentMeasurements').where('ParentId', isEqualTo: measurement).get();

      final list = snapshot.docs.map((document) => MeasurementModel.fromSnapshot(document)).toList();
      
      return list;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> deleteMeasurement(String materialId) async {

    try {
      await _db.collection('Measurements').doc(materialId).delete();

    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }



  Future<List<GarmentMeasurementModel>> getAllccessories() async {
    
    try {
      final snapshot = await _db.collection('GarmentMeasurements').get();

      final result = snapshot.docs.map((doc) => GarmentMeasurementModel.fromSnapshot(doc)).toList();
      
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
  

// get sub categories
    Future<List<GarmentMeasurementModel>> getAllGarmentMeasuremnt(String garmentId) async {
    
    try {
      final snapshot = await _db.collection('GarmentMeasurements').where('GarmentId', isEqualTo: garmentId).get();

      final list = snapshot.docs.map((document) => GarmentMeasurementModel.fromSnapshot(document)).toList();
      
      return list;


    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }



  Future<String> assignMeasurement(GarmentMeasurementModel measurement) async {

    try {
      final data = await _db.collection('GarmentMeasurements').add(measurement.toJson());
      return  data.id;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;    
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }


  Future<void> deleteAAssociatedccessory(String measurementId, String garmentId ) async {
    
      try {
     final result =  await _db
          .collection('GarmentMeasurements').where('MeasurementId', isEqualTo: measurementId).where('GarmentId', isEqualTo: garmentId).get();
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