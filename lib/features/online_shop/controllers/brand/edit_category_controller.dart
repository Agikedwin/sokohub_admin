import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/brand/brand_repository.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditBrandController extends GetxController { 

  static EditBrandController get instance => Get.find();

  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;


  
void init(BrandModel brand) {
  name.text = brand.name;

  imageURL.value = brand.image;

  isFeatured.value = brand.isFeatured ?? false;

  selectedCategories.clear();

  if (brand.brandCategories != null &&
      brand.brandCategories!.isNotEmpty) {
    selectedCategories.addAll(brand.brandCategories!);
  }
}

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
  isLoading(false);
  isFeatured(false);
  name.clear();
  imageURL.value = '';
  selectedCategories.clear();
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
  

  Future<void> updateBrand(BrandModel brand) async {


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

      // Is Data Updated
      bool isBrandUpdated = false;
      if(brand.image != imageURL.value || brand.name != name.text.trim() || brand.isFeatured != isFeatured.value){
        isBrandUpdated = true;

         // Map Data
         brand.name = name.text.trim();
           brand.image = imageURL.value;
           brand.isFeatured = isFeatured.value;
           brand.updatedAt = DateTime.now();

           // call Repository to update
           await repository.updateBrand(brand);

      }

      // Update Brand data in Product
      if(selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Product
      if(isBrandUpdated) await updateBrandInProducts(brand);

      // Update All Data list
      BrandController.instance.updateItemFromlist(brand);    

      

           // Remove Loader
        TFullScreenLoader.stopLoading();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Record has been updated.');   

        //Get.back();     
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  }

  
updateBrandCategories(BrandModel brand) async {
  // Fetch all brand categories
  final brandCategories = await repository.getCategoriesOfSpecicBrand(brand.id);

  // SelectedCategoryIds
  final selectedCategoryIds = selectedCategories.map((e) =>e.id);

  //Identify Category to remove
  final categoriesToRemove = 
  brandCategories.where((existingCategory) => !selectedCategoryIds.contains(existingCategory.categoryId)).toList();

  //Remove unselected categories
  for(var categoryToRemove in categoriesToRemove){
    await BrandRepository.instance.deleteBrandCategory(categoryToRemove.id ?? '');
  }

  // Identify new categories to add
   final newCategoriesToAdd = 
  selectedCategories.where((newCategory) => !brandCategories.any((existingCategory) => existingCategory.categoryId == newCategory.id)).toList();

  // Add new Categories
  for(var newCategory in newCategoriesToAdd){
    var brandCategory =BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
    brandCategory.id = await BrandRepository.instance.createBrandCategory(brandCategory);

  }
  brand.brandCategories!.assignAll(selectedCategories);
  BrandController.instance.updateItemFromlist(brand);


} 


  // Udate Products of this Brand
  updateBrandInProducts(BrandModel brand) async{

  }

  

}