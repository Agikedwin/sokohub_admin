 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sokohub_admin/data/repositories/setting/settings_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/setting_model.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class  SettingController extends GetxController{
  static SettingController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<SettingModel> settings = SettingModel().obs;

  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();
  

  GlobalKey<FormState>  formKey = GlobalKey<FormState>();


   final settingRespository = Get.put(SettingsRepository());

   @override
  void onInit() {
    fetchAllSettingDetails();    
    super.onInit();
  }

  Future<SettingModel> fetchAllSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingRespository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text = settings.freeShippingThreshold == null ? '' : settings.freeShippingThreshold.toString();

      loading.value = false;
      return settings;     
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return SettingModel();
      
    }
  }

  // Pick Thumbnail Image from Media

  Future updateAppLogo() async{
    try {
      
    loading.value = true;
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Hand the selected Images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other action

      ImageModel selectedImage = selectedImages.first;

      // Update the profile
      await settingRespository.updateSelectedField({'appLogo': selectedImage.url});

      // Update the main image using the selected image
      settings.value.appLogo = selectedImage.url;
      settings.refresh();

        TLoaders.successSnackBar(title: 'Congratulations', message: 'App Logo has been updated');
    }
    loading.value = false;

   

      
      
    } catch (e) {
       loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
      
    }
  }

  /// Add new address
  
  Future<void> updateSettingInformation() async {
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

     settings.value.appName = appNameController.text.trim();
     settings.value.taxRate = double.tryParse(taxController.text.trim())  ?? 0.0 ;
      settings.value.shippingCost = double.tryParse(shippingController.text.trim())  ?? 0.0 ;
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim())  ?? 0.0 ;

      await settingRespository.updateSettingDetails(settings.value);
      settings.refresh();

     


      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'App Settings has been updated.');

     
       loading.value = false;

      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  

  void resetFormFields() {
  appNameController.clear();
  taxController.clear();
  shippingController.clear();
  freeShippingThresholdController.clear();

}


} 