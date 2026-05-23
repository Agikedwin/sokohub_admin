import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  /// Fuction to create user data to firestore

  Future<void> createUser(UserModel user) async {
    try {
      return await _db.collection('Users').doc(user.id).set(user.toJson());
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

  /// Fuction to fetch user details based on user ID

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromDocSnapshot(documentSnapshot);
      }
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
    return UserModel.empty();
  }

  /// Fetch all users
  Future<List<UserModel>> getAllUsers() async {

 try {
      final users = await _db
          .collection('Users').get();

      final result = users.docs.map((doc) => UserModel.fromDocSnapshot(doc)).toList();
      if(result.isNotEmpty){
        return result;
      }else {
        return [];
      }
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

// Fetch UserOrders
   Future<UserModel> fetchUserDetail(String id) async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(id)
          .get();



      if (documentSnapshot.exists) {

        return UserModel.fromDocSnapshot(documentSnapshot);
      }else{

        return UserModel.empty();
      }
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
    return UserModel.empty();
  }

// Fetch admin details

  Future<UserModel> fetchAdminDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromDocSnapshot(documentSnapshot);
      }
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
    return UserModel.empty();
  }

  /// Fuction to update user data in Firestore

  Future<UserModel> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
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
    return UserModel.empty();
  }

  /// Fuction to update any specific Users Collection

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
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

  /// Fuction to update any specific Users Collection

  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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


 /// Fuction to update any specific Users Collection
 
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

 }

  Future<List<OrderModel>?> fetchUserOrders(String userId) async {
     print('---------------------------$userId');
     try {
      final documentSnapshot = await _db
          .collection('Orders').where('UserId', isEqualTo: userId).get();



      if (documentSnapshot.docs.isNotEmpty) {

        return documentSnapshot.docs.map((doc) => OrderModel.fromQuerySnapshot(doc)).toList();
      }else{

        return [];
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
