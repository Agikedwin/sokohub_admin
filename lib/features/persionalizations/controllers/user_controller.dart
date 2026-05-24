import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class UserController extends GetxController {

  static UserController get instance => Get.find();

  final loading = false.obs;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final userrepository = Get.put(UserRepository());
  
  /// Re-Auth user variables
  final hidePassword =false.obs;
  final verifyEmail = TextEditingController();
   final verifyPassword = TextEditingController();
  
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // TextControllers
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();




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
      loading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user.value = user;
      return user;
      
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Something Went Wrong',
      message:  e.toString());
      return UserModel.empty();
    }finally{
      loading.value = false;
    }
  }


  

  Future<void> updateUserInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      
      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();

      loading.value = false;


      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile has been updated.');

      
    } catch (e) {
     loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload Profile Picture
  void uploadUserProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        // Set the selected image
        ImageModel selectedImage = selectedImages.first;

        //Update Profile in firestore
        await userRepository.updateSingleField({'profilePicture': selectedImage.url});

        // update the main image using selected image
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Image has been updated!');
      }
      loading.value = false;
        
      
    } catch (e) {
      loading.value = true;
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally {
     loading.value = false;
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