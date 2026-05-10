import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase  Storage instance

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload any image using File

  Future<ImageModel> uploadImageFileInStorage(
      {required Uint8List file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');

      // Upload file
      await ref.putData(file);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          metadata, path, imageName, downloadURL);
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
      final data = await FirebaseFirestore.instance
          .collection('Images')
          .add(image.toJson());

      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e, trace) {
      print(trace);
      print(e);
      throw e.toString();
    }
  }

  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs
          .map((data) => ImageModel.fromSnapshot(data))
          .toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e, trace) {
      print(trace);
      print(e);
      throw e.toString();
    }
  }

  ///Load more images
  Future<List<ImageModel>> loadMoreImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
    DateTime lastFetchDate,
  ) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where(
            'mediaCategory',
            isEqualTo: mediaCategory.name,
          )
          .orderBy('createdAt', descending: true)
          .startAfter([Timestamp.fromDate(lastFetchDate)])
          .limit(loadCount)
          .get();

      return querySnapshot.docs
          .map((data) => ImageModel.fromSnapshot(data))
          .toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e, trace) {
      print(trace);
      print(e);
      throw e.toString();
    }
  }

   ///Delete files from Firebase storage and corresponding document from Firestore
  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();

      
    } on FirebaseException catch (e) {
      throw e.message ?? ' Something went wrong while deleting the image';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e, trace) {
      print(trace);
      print(e);
      throw e.toString();
    }
  }
}
