import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class BannerRepository  extends GetxController{

  static BannerRepository get instance => Get.find();

/// Varibles
  final _db = FirebaseFirestore.instance;

  /* /// Get all categories
  
  Future<List<BannerModel>> getAllBanners() async {
    
    try {
      final snapshot = await _db.collection('Banners').where('active', isEqualTo: true).get();

      final list = snapshot.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      
      return list;


    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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
  
  /// Get Sub Categories
  /// 
  /// Fuction to save user data to firestore

  Future<void> saveBanner(BannerModel banner) async {
    try {
      return await _db.collection('Banners').doc(banner.id).set(banner.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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


  Future<void> updateSingleField(Map<String, dynamic> json, String id) async {
    try {
      await _db
          .collection('Banners')
          .doc(id)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  

  /// Fuction to update user data in Firestore

  Future<BannerModel> updateCategoryDetails(BannerModel updateBanner) async {
    try {
      await _db
          .collection('Categories')
          .doc(updateBanner.id)
          .update(updateBanner.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return BannerModel.empty();
  }


  /// Upload categories to the cloud Firestore
  
 Future<String> uploadImage(String path, XFile image) async{
  try {
 final  ref = FirebaseStorage.instance.ref(path).child(image.name);
 await ref.putFile(File(image.path));

 final url = await ref.getDownloadURL();
 return url;


 
  } on FirebaseAuthException  catch (e) {
    throw TFirebaseAuthException(e.code).message;    
  } on FirebaseException catch (e){
    throw TFirebaseException(e.code).message;
  }  on FormatException catch (_){
    throw const  TFormatException();
  } on PlatformException catch (e){
    throw TFormatException(e.code).message;
  } catch (e){
    throw 'Some thing went wrong, Please try again';
  }


 } */
}