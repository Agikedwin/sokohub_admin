import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class BannerRepository  extends GetxController{

  static BannerRepository get instance => Get.find();

/// Varibles
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  
  Future<List<BannerModel>> getAllBanners() async {
    
    try {
      final snapshot = await _db.collection('Banners').get();

      final list = snapshot.docs.map((document) => BannerModel.fromSnapshot(document)).toList();
      
      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }
  
  /// Get Sub Categories
  /// 
  /// Fuction to save user data to firestore

  Future<String> createBanner(BannerModel banner) async {
    try {
      final result = await _db.collection('Banners').add(banner.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Fuction to update user data in Firestore

  /// Function to update banner data in Firestore
Future<void> updateBanner(BannerModel banner) async {
  try {
    if (banner.id!.isEmpty) {
      throw 'Banner ID is empty.';
    }

    await _db
        .collection('Banners')
        .doc(banner.id)
        .update(banner.toJson());

  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;

  } on FormatException {
    throw const TFormatException();

  } on SocketException catch (e) {
    throw e.message;

  } catch (e, trace) {
    print('ERROR: $e');
    print('TRACE: $trace');

    throw 'Something went wrong. Please try again.';
  }
}


  /// Upload categories to the cloud Firestore
  
 Future<String> uploadImage(String path, XFile image) async{
  try {
 final  ref = FirebaseStorage.instance.ref(path).child(image.name);
 await ref.putFile(File(image.path));

 final url = await ref.getDownloadURL();
 return url;


 
  } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }


    Future<void> deleteBanner(String bannerId) async {
    try {
      await _db
          .collection('Banners')
          .doc(bannerId)
          .delete();
   } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  
  }


 }
