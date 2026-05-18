import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/banner/banner_repository.dart';
import 'package:sokohub_admin/data/repositories/brand/brand_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/banner_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/routes/app_screens.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateBannerController extends GetxController {

  static CreateBannerController get instance => Get.find();

  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppAscreenItems[0].obs;
  final formKey = GlobalKey<FormState>();
  final  name = TextEditingController();


  // Method to reset fields
 void resetFields() {
  isLoading(false);
  isActive(false);
  targetScreen.value = '';
  imageURL.value = '';
 }


// Pick  thimbnail image from media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected images 
    if(selectedImages != null && selectedImages.isNotEmpty){
      
      // set selected images  using the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }

  }
  

  Future<void> createBanner() async {


    try {
      // Start loading Connectivity
      TFullScreenLoader.popUpCircular();

        //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

      // validate form field
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

        // Map Data

        final newRecord = BannerModel(
          id: '',
          name: name.text.trim(),
           targetScreen: targetScreen.value, 
           imageUrl: imageURL.value,
           active: isActive.value,
           );

          // Call Repository to Create New Brand
           newRecord.id =  await BannerRepository.instance.createBanner(newRecord);   

           // Update All data Liat
           BannerController.instance.addItemTolist(newRecord);       
          

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New Record has been added.');    

        Get.back();     
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 



}