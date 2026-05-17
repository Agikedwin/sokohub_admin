import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateCategoryController extends GetxController {

  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();


  

  // Pick thumbnail image from media


  // Register new category

  Future<void> createCategory() async {


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

        final newRecord = CategoryModel(
          id: '',
           name: name.text.trim(), 
           image: imageURL.value,
           isFeatured: isFeatured.value,
           parentId: selectedParent.value.id,
           createdAt: DateTime.now()
           );

          
           newRecord.id =  await CategoryRepository.instance.createCategory(newRecord);

           // Update Data list

           CategoryController.instance.addItemTolist(newRecord);

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
  selectedParent(CategoryModel.empty());
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