import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sokohub_admin/data/repositories/setting/settings_repository.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/authentication/screens/login/login.dart';
import 'package:sokohub_admin/features/persionalizations/models/setting_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Firebase Auth Instance
  final _auth = FirebaseAuth.instance;

  //Get Authenticated User Data

  User? get authUser => _auth.currentUser;

  // Get IsAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    // TODO: implement onReady
    // Redirect to the appropriate screen
   _auth.setPersistence(Persistence.LOCAL);
  }


///Determine the relevant screen and redirect accordingly
  Future<void> screenRedirect() async {
    User? user = _auth.currentUser;

    // if user is logged in
    if (user != null) {
        /// If User Email is verified,  Navigate to main Menu
        Get.offAllNamed(ITRoutes.dashboard);
      
    }else {
        /// Redirect the user to the login screen

        Get.offAllNamed((ITRoutes.login));
      }
  }


  /// Login function
  Future<UserCredential> loginWithEmailAndPassword(String email,  String password) async {
    try {

      return await _auth.signInWithEmailAndPassword(email: email, password: password);
        
      
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


  /// Register function
  Future<UserCredential> resterWithEmailAndPassword(String email,  String password) async {
    try {
      print(email);  
      print(password);
      final admin =  await _auth.createUserWithEmailAndPassword(email: email, password: password);    

      // Register app
      final settingController = Get.put(SettingsRepository());
      await settingController.registerSettings(SettingModel.empty());

      return admin;
        
      
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


   // [EmailAuthentication] - SugnIn

 Future<UserCredential> registerWithEmailAndPsaaword(String email, String password) async{
  try {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
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



 /// [LogoutUser] - Valid for any authentication
 Future<void> logout() async{
  try {
    await FirebaseAuth.instance.signOut();

   // Get.offAll(() => const LoginScreen());
    
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

 /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.deleteUser(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


}
