import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class LoginController  extends GetxController{

  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final remembeMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
     password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }


  /// Handle email and password sign-in process
  
  Future<void> emailAndPasswordSignIn() async{
    try {
        /// Validate Form
   /*  if(!loginFormKey.currentState!.validate()){
      return;
    } */

      // Start Loading
    TFullScreenLoader.openLoadingDialog('Logginin you in...',  TImages.docerAnimation);
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      return;
    }

  
    // Save data if remember me is selected
    if(remembeMe.value){
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }


    // Login user using email and password Authentication
    await AuthenticationRepository.instance.loginWithEmailAndPassword(TTexts.adminEmail, TTexts.adminPassword); //email.text.trim(), password.text.trim()

    // Fetch user details and assign to UserController
    final user = await UserController.instance.fetchUserRecord();

    // Remove Loader
    TFullScreenLoader.stopLoading();

    //User Data
    final data = user.toJson();

    // If user is not admin, logout and return
    if(data['Role'] != AppRole.admin.name.toString()){
      await AuthenticationRepository.instance.logout();
      TLoaders.errorSnackBar(title: 'Not Authorized', message: 'You are not authorized or do not have access. Contact Admin');

    }else {
      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    }

      
    } catch (e, trace) {
      print(trace);

      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }

  }
  


  // Handle registration of admin user
  Future<void> resisterAdmin() async {
    print('Register Admin');

    try {
         /// Validate Form
    if(!loginFormKey.currentState!.validate()){
      return;
    }

      // Start Loading
    TFullScreenLoader.openLoadingDialog('Registering Admin Account',  TImages.docerAnimation);
    print('Register Admin 1');

    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected){
      TFullScreenLoader.stopLoading();
      return;
    }

    print('Register Admin 3');

    // register user using email and password Authentication

    await AuthenticationRepository.instance.resterWithEmailAndPassword(TTexts.adminEmail, TTexts.adminPassword);
    
      // Create admin record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(UserModel(
        id: AuthenticationRepository.instance.authUser!.uid,
        firstName: 'Agik',
        lastName: 'Edwin',
        email: TTexts.adminEmail,
        role: AppRole.admin,
        createdAt: DateTime.now(),
        isEmailVerified: false,
        isProfileActive: true
          ));

      TFullScreenLoader.stopLoading();
        
      } catch (e, trace) {
        print(trace);

        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
      }

  }

}