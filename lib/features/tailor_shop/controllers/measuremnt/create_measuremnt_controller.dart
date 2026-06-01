import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/garment/garment_repository.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/material/material_repository.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/measurement/measurement_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateMeasurementController extends GetxController {

  static CreateMeasurementController get instance => Get.find();

  final selectedParent = MeasurementModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final wage = TextEditingController();
    final unitCost = TextEditingController();

  final formKey = GlobalKey<FormState>();


  

  // Pick thumbnail image from media


  // Register new category

  Future<void> createMeasurement() async {


    try {
      // Start loading
      TFullScreenLoader.popUpCircular();

        //Check Internet
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

        final newRecord = MeasurementModel(
          id: '',
           name: name.text.trim(), 
           image: imageURL.value,
           createdAt: DateTime.now()
           );

          
           newRecord.id =  await MeasurementRepository.instance.createMeasurement(newRecord);

           // Update Data list

           MeasurementController.instance.addItemTolist(newRecord);

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New record successfully added');        
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 


  // Method to reser fields
 void resetFields() {
  selectedParent(MeasurementModel.empty());
  isLoading(false);
  isFeatured(false);
  name.clear();
  imageURL.value = '';
  wage.clear();
  name.clear();
 }

// Pick  thimbnail image from media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImageFromMedia();

    // Handle the selected images 
    if(selectedImages != null && selectedImages.isNotEmpty){
      
      // set selected images  using the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      // Updayr the main image using the selectedImage

      imageURL.value = selectedImage.url;
    }

  }
  

}