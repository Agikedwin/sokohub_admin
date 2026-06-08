import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';

class GarmentSelectionRepository extends GetxController {
  static GarmentSelectionRepository get instance => Get.find();

  /// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all categories from Category collection

  Future<List<ClientSelectionAttributesModel>> getAllGarmentSelections() async {
    print('called here');

    try {
      final snapshot = await _db.collection('ClientSelectionOrder').get();

      final result = snapshot.docs
          .map((doc) => ClientSelectionAttributesModel.fromSnapshot(doc))
          .toList();
      print(result.length);

      return result;
    } on TFirebaseException catch (e ) {

      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e ) {

      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<ClientSelectionAttributesModel> getAllGarmentSelectionsById(
      String clientSectionId) async {
    print('called here  ====================================================================== $clientSectionId');

    try {
      final snapshot = await _db
          .collection('ClientSelectionOrder')
          .doc(clientSectionId)
          .get();

      if (snapshot.exists) {
        final result = ClientSelectionAttributesModel.fromSnapshot(snapshot);

        return result;
      }

      return ClientSelectionAttributesModel.empty();
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Something went wrong, please try again';
    }
  }

  /// Get Sub GarmentSelections
  ///
  /// Fuction to save user data to firestore

  Future<String> createGarmentSelection(
      ClientSelectionAttributesModel material) async {
    try {
      final data =
          await _db.collection('ClientSelectionOrder').add(material.toJson());
      return data.id;
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
      await _db.collection('Users').doc(id).update(json);
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Fuction to update user data in Firestore

  Future<ClientSelectionAttributesModel> updateGarmentSelection(
      ClientSelectionAttributesModel material) async {
    try {
      await _db
          .collection('ClientSelectionOrder')
          .doc(material.id)
          .update(material.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
    return ClientSelectionAttributesModel.empty();
  }

  Future<void> deleteGarmentSelection(String materialId) async {
    try {
      await _db.collection('ClientSelectionOrder').doc(materialId).delete();
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }
}
