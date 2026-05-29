import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/material/material_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditMaterialController extends GetxController  {

  static EditMaterialController get instance => Get.find();

  final selectedParent = MaterialModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final unitCost = TextEditingController();
  final formKey = GlobalKey<FormState>();


  
  // Init Data
void init(MaterialModel material){
  name.text = material.name.trim();
  imageURL.value = material.image;
  isFeatured.value =material.isFeatured;
  unitCost.text =  material.unitCost.toString();


  if(material.parentId.isNotEmpty){
    selectedParent.value = MaterialController.instance.allItems.where((m) => m.id == material.parentId).single;
  }

  material.parentId = selectedParent.value.id;
}
  

  // Pick thumbnail image from media


  // Register new category

  Future<void> updateMaterial(MaterialModel material) async {


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

       
           material.name = name.text.trim();
            material.image = imageURL.value;
            material.unitCost = double.tryParse(unitCost.text.toString()) ?? 0.0;
            material.isFeatured = isFeatured.value;
            material.parentId = selectedParent.value.id;
            material.updatedAt = DateTime.now();
           

          
           await MaterialRepository.instance.updateMaterial(material);

           // Update Data list

          MaterialController.instance.updateItemFromlist(material);
          
         

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();
        // Navigate back to the list
         Get.back();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New record successfully added');        
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 


  // Method to reset fields
 void resetFields() {
  selectedParent(MaterialModel.empty());
  isLoading(false);
  isFeatured(false);
  name.clear();
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

      // Updayr the main image using the selectedImage

      imageURL.value = selectedImage.url;
    }

  }
  

}