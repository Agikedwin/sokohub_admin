import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class UserController extends GetxController {

  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final userrepository = Get.put(UserRepository());
  
  /// Re-Auth user variables
  final hidePassword =false.obs;
  final verifyEmail = TextEditingController();
   final verifyPassword = TextEditingController();
  
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

   // Profile Screen Controllers
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final fullName = TextEditingController();
  final imageUploading = false.obs;
  final profileImageUrl = ''.obs;
  GlobalKey<FormState> updateUserProfileFormKey = GlobalKey<FormState>();


  @override
  void onInit(){

    super.onInit();
    fetchUserRecord();

  }
  /// fetch user record
  
  Future<UserModel> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      return user;
      
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Something Went Wrong',
      message:  e.toString());
      return UserModel.empty();
    }
  }


  /// Save user Record from any Registration provider
  
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {

      /// First update Rx User then check if user data is already stored, If not, store new data
      
      await fetchUserRecord();

      // If no record already stored

      if(user.value.id.isEmpty){

      if(userCredential != null){
        // Convert name to First and Last Names
        final nameparts = UserModel.nameParts(userCredential.user!.displayName ?? '');
        final username = UserModel.generateUsername(userCredential.user!.displayName ?? '');

        //Map user data
        final user = UserModel(
          id: userCredential.user!.uid,
          firstName: nameparts[0],
          lastName: nameparts.length > 1 ? nameparts.sublist(1).join(' ') : '',
          username: username,
           email: userCredential.user!.email ?? '',
           phoneNumber: userCredential.user!.phoneNumber ?? '',
            isEmailVerified: true,
             profilePicture: userCredential.user!.photoURL ?? '',
             isProfileActive: true
             );

             // Save user data
            // await userRepository.saveUserRecord(user);
      }
    }
      
    } catch (e) {

      TLoaders.warningSnackBar(
        title: 'Data not saved',
      message:  'Something went wrong while saving your information. You can re-save your data in your profile');
      
    }
  }



  Future<void> updateUserProfile() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserProfileFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> json = {'fullName': fullName.text.trim(), 'email': email.text.trim()};
      await userRepository.updateSingleField(json);

      // Update the Rx User value
     // user.value.fullName = fullName.text.trim();
      user.value.email = email.text.trim();
      user.value.phoneNumber = phoneNo.text.trim();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated.');

      // Move to previous screen.
     // Get.offNamed(TRoutes.profileScreen);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload Profile Picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final uploadedImage = await userRepository.uploadImage('Users/Images/Profile/', image);
        profileImageUrl.value = uploadedImage;
        Map<String, dynamic> newImage = {'profilePicture': uploadedImage};
        await userRepository.updateSingleField(newImage);
        user.value.profilePicture = uploadedImage;
        user.refresh();

        imageUploading.value = false;
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      imageUploading.value = false;
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally {
      imageUploading.value = false;
    }
  }
 
  /// Update user record after login (e.g., to update token)
  Future<void> updateUserRecordWithToken(String newToken) async {
    try {
      // Ensure we have fetched the user record before updating
      await fetchUserRecord();
      // Create a map to store the fields we want to update (e.g., token)
      Map<String, dynamic> updatedFields = {'deviceToken': newToken};

      // Call the repository to update the specific fields
      await userRepository.updateSingleField(updatedFields);

      // Update the local RxUser object with the new token
      user.value.deviceToken = newToken;
      user.refresh();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update user record: $e',
      );
    }
  }

  /// Delete Account Warning
 /*  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ITSizes.md),
      title: 'Delete Account',
      middleText:
      'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
       confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: ITSizes.lg), child: Text('Delete')),
      ), 
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  } */
/* 
  /// Delete User Account
  void deleteUserAccount() async {
   
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);


      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).last;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.to(() => const LoginScreen());
         // Get.offAllNamed(TRoutes.logIn);
        } else if (provider == 'facebook.com') {
          TFullScreenLoader.stopLoading();
         // Get.offAllNamed(TRoutes.logIn);
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }else if (provider == 'phone') {
          TFullScreenLoader.stopLoading();
          //await AuthenticationRepository.instance.loginWithPhoneNo(user.value.phoneNumber);
         // bool otpVerified = await Get.toNamed(TRoutes.reAuthenticateOtpVerification, parameters: {'phoneNumberWithCountryCode': user.value.phoneNumber});
         /// if (otpVerified) {
            TLoaders.successSnackBar(title: ITTexts.phoneVerifiedTitle, message: ITTexts.phoneVerifiedMessage);
          //  await auth.deleteAccount();
          //  Get.offAll(() => const WelcomeScreen());
          }
        }
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  } */
 
  /// -- RE-AUTHENTICATE before deleting
 /*  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', ITImages.docerAnimation);

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

       await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() =>LoginScreen()); 
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  } */

  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Logout',
        middleText: 'Are you sure you want to Logout?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Confirm'),
          ),
          onPressed: () async {
            onClose();

            /// On Confirmation show any loader until user Logged Out.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              //content: const TCircularLoader(),
            );
           // await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void assignDataToProfile(){
    fullName.text = user.value.fullName;
    email.text = user.value.email;
    phoneNo.text = user.value.phoneNumber;
  }


}