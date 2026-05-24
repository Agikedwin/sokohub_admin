import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/features/persionalizations/models/setting_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class SettingsRepository  extends GetxController{
  static SettingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<SettingModel> getSettings() async {

   try {
    

    final result = await _db.collection('Settings').doc('GLOABAL_SETTINGS').get();
    return SettingModel.fromSnapshot(result);
     
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


// Update app logo  
   Future<void> updateSelectedField(Map<String, dynamic> appLogo) async{
    try {
       await _db.collection('Settings').doc('GLOABAL_SETTINGS').update(appLogo);
      
    } catch (e) {
      throw 'Unable to update your address selection';
      
    }
  }


// Store new  Settings order
  Future<void> registerSettings(SettingModel setting) async {
    try {
      await _db.collection('Settings').doc('GLOABAL_SETTINGS').set(setting.toJson());
      
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

  Future<void> updateSettingDetails(SettingModel updateSettings) async {
     try {
      await _db.collection('Settings').doc('GLOABAL_SETTINGS').update(updateSettings.toJson());
      
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