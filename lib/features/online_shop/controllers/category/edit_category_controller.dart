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

class EditCategoryController extends GetxController {

  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();


  
  // Init Data
void init(CategoryModel category){
  name.text = category.name;
  imageURL.value = category.image;
  isFeatured.value =category.isFeatured;

  if(category.parentId.isNotEmpty){
    selectedParent.value = CategoryController.instance.allItems.where((c) => c.id == category.parentId).single;
  }

  category.parentId = selectedParent.value.id;
}
  

  // Pick thumbnail image from media


  // Register new category

  Future<void> updateCategory(CategoryModel category) async {


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

       
           category.name = name.text.trim();
            category.image = imageURL.value;
            category.isFeatured = isFeatured.value;
            category.parentId = selectedParent.value.id;
            category.updatedAt = DateTime.now();
           

          
           await CategoryRepository.instance.updateCategory(category);

           // Update Data list

          CategoryController.instance.updateItemFromlist(category);
          
         

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