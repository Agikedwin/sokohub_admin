import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sokohub_admin/data/repositories/banner/banner_repository.dart';
import 'package:sokohub_admin/data/repositories/brand/brand_repository.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/banner_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/routes/app_screens.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditBannerController extends GetxController { 

  static EditBannerController get instance => Get.find();

 final isLoading = false.obs;
  final imageURL = ''.obs;
  final isActive = false.obs;
  final  targetScreen = ''.obs;
  final formKeyEdit = GlobalKey<FormState>();
  final  name = TextEditingController();
  final repository = Get.put(BannerRepository());


 
 /// Init Data
 
 void init(BannerModel banner){
  imageURL.value = banner.imageUrl;
  isActive.value = banner.active;
  targetScreen.value = banner.targetScreen;
  name.text = banner.name;
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
  

  Future<void> updateBanner(BannerModel banner) async {


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
      if (!formKeyEdit.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

        // Is  Data Updated
        if(banner.imageUrl != imageURL.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value || banner.name != name.text.trim()){
          
          banner.imageUrl = imageURL.value;
          banner.targetScreen = targetScreen.value;
          banner.active = isActive.value;
          banner.name = name.text.trim();

          print(banner.id);

          // Call Repository to Create New Brand
          await BannerRepository.instance.updateBanner(banner);   

        }
           // Update All data Liat
           BannerController.instance.updateItemFromlist(banner);       
          


           // Remove Loader
        TFullScreenLoader.stopLoading();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New Record has been added.');    

      
      
    } catch (e, trace) {
      print(e);
      print(trace);
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 


  

}