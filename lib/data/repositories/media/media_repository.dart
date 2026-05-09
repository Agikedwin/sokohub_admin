import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';

class MediaRepository  extends GetxController{
  static MediaRepository get instance => Get.find();

  // Firebase  Storage instance

  final FirebaseStorage _storage = FirebaseStorage.instance;

/// Upload any image using File

   Future<ImageModel> uploadImageFileInStorage({required Uint8List file, required String path, required String imageName}) async {
    try {
   
     
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');

      // Upload file
      await ref.putData(file);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // fetch metadata
       final FullMetadata metadata = await ref.getMetadata();

       return ImageModel.fromFirebaseMetadata(metadata, path, imageName, downloadURL);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
     throw e.toString();
    }
    
  }

  Future<String> uploadImageFileInDatabase(ImageModel image) async {

   try {
     
      final data = await FirebaseFirestore.instance.collection('Images').add(image.toJson());

      return data.id;

     

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
     throw e.toString();
    }

  }

  
}