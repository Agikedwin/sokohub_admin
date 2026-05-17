import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/brand/brand_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateBrandController extends GetxController {

  static CreateBrandController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

// Toggle Category Selection

void toggleSelection(CategoryModel category){
  if(selectedCategories.contains(category)){
    selectedCategories.remove(category);
  }else{
    selectedCategories.add(category);
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

      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }

  }
  

  Future<void> createBrand() async {


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

        final newRecord = BrandModel(
          id: '',
          productCount: 0,
           name: name.text.trim(), 
           image: imageURL.value,
           isFeatured: isFeatured.value,
           createdAt: DateTime.now()
           );

          // Call Repository to Create New Brand
           newRecord.id =  await BrandRepository.instance.createBrand(newRecord);

           // Register brand category if any
           if(selectedCategories.isNotEmpty){
            if(newRecord.id.isEmpty) throw 'Error storing relational data. Try again';

            // Loop Selected btand Categories
            for(var category in selectedCategories){
              // Map Data
              final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id);
              await BrandRepository.instance.createBrandCategory(brandCategory);
            }

            newRecord.brandCategories ??= [];
            newRecord.brandCategories!.addAll(selectedCategories);
           }

           // Update All Data list
           BrandController.instance.addItemTolist(newRecord);
          

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