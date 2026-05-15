import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class CategoryController extends GetxController{

  static CategoryController get instance => Get.find();

  final isLoading = false.obs;

  final categoryRepository = Get.put(CategoryRepository());

 // final bannerController = Get.put(BannerController());

  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
   RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
   RxList<bool> selectedRows = <bool>[].obs;
    Rx<CategoryModel> category = CategoryModel.empty().obs;
    RxList<CategoryModel> maxCategoryIdModel = <CategoryModel>[].obs;

    // Sorting
    RxInt sortColumnIndex = 1.obs;
    RxBool sortAscending = true.obs;

    // Search
    final searchTextController = TextEditingController();
    

      // Profile Screen Controllers
  final imageName = TextEditingController(); 
  final imageUploading = false.obs;
  final imageUrl = ''.obs;
  var maxCategoryValue = ''.obs;
  GlobalKey<FormState> imageUploadFormKey = GlobalKey<FormState>();

  @override
  void onInit(){
   fetchCategories();
    super.onInit();
  }

  /// -- Load Category data
  Future<void> fetchCategories() async {
    try {
     
      /// Show loader while loading categories
      isLoading.value = true;

      List<CategoryModel> fetchedItems = [];     

      /// Fetch categories from data source
      if(allItems.isEmpty){
        fetchedItems = await categoryRepository.getAllCategories();
      }
       
      /// Update the category list
     allItems.assignAll(fetchedItems);
     filteredItems.assignAll(fetchedItems);

     // generate list to assign to the selectable table rows
     selectedRows.assignAll(List.generate(allItems.length, (_) => false));

      /// Filtered featured categories
     // featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId!.isEmpty).take(categories.length).toList());
       isLoading.value = false;
    } catch (e, stack ) {
       isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh, Snap!', message: e.toString());
      
    }finally{
      /// remove Loader
    //  TFullScreenLoader.stopLoading();
      isLoading.value = false;
  }
  /// -- Load selected category data
  /// Get Category or Sub-Category products
}

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a,b){
      if(ascending){
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }else{
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  void sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a,b){
      if(ascending){
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }else{
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  searchQuery(String query){
   filteredItems.assignAll(
    allItems.where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
   );
  }

  void confirmAndDeleteItem(CategoryModel category) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to Delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(category), 
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight /2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5)),
          ),
          child: Text('Ok')),
      ),
      cancel:  SizedBox(
        width: 60,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight /2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5)),
          ),
          child: Text('Cancel')),
      ),
    );
  }
  
deleteOnConfirm(CategoryModel category) async {

  try {
    // remove the confirmation Dialogue
  TFullScreenLoader.stopLoading();

  //Start the Loader
  TFullScreenLoader.popUpCircular();

  // Delete Category
  await categoryRepository.deleteCategory(category.id);

  removeItemFromLists(category);

  TFullScreenLoader.stopLoading();
  TLoaders.successSnackBar(title: 'Item Deleted', message: 'Your Item has been Deleted');
    
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    
  }
  

}

// Method for removing Items the list

void removeItemFromLists(CategoryModel item){
  allItems.remove(item);
  filteredItems.remove(item);
  selectedRows.assignAll(List.generate(allItems.length, (index) => false));  //Initialize selected rows
}

  void addItemTolist(CategoryModel item) {
    allItems.add(item);
  filteredItems.add(item);
  selectedRows.assignAll(List.generate(allItems.length, (index) => false));  //Initialize selected rows

  filteredItems.refresh();  // refresh UI to reflect the changes
  }

// Method for updating an item in the list

 void updateItemFromlist(CategoryModel item) {
    allItems.add(item);
  filteredItems.add(item);
  selectedRows.assignAll(List.generate(allItems.length, (index) => false));  //Initialize selected rows

  filteredItems.refresh();  // refresh UI to reflect the changes
  }
  

/// -- Get max category id
/* String maxCategoryId(){
  

  if (allCategories.isNotEmpty) {
  // 2. Find the model with the maximum categoryId
  // Assumes categoryId is a type that can be compared (int or double)
  var maxCategoryValue = allCategories.reduce((curr, next) => 
    int.parse(curr.id) > int.parse(next.id) ? curr : next);

    maxCategoryIdModel.assign(maxCategoryValue);
    // convert to int 
    return maxCategoryIdModel.last.id;
    
  }else {
    return '0';
  }

 

}


/// --- Upload Category Imabe
Future<void>  uploadCategoryImage() async {
    try {
      // validate form field
      if (!imageUploadFormKey.currentState!.validate()) {
       // TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Image Name required!!');
      }else{
         //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

        // pick file and upload
        final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // start uploading image 
        TFullScreenLoader.openLoadingDialog('Processing', ITImages.docerAnimation);

     
        final uploadedImage = await categoryRepository.uploadImage('Categories/', image);
        imageUrl.value = uploadedImage;
        Map<String, dynamic> newImage = {'Image': uploadedImage};
        // conver id to int and increament by 1
        int intValue = int.parse(maxCategoryId()) + 1;
        CategoryModel categoryModel = CategoryModel(id: intValue.toString(), image: newImage['Image'],isFeatured: true,  name: imageName.text.trim());
        await categoryRepository.saveCategoryRecord(categoryModel);
        featuredCategories.add(categoryModel);
        featuredCategories.refresh();
        //await categoryRepository.updateSingleField(newImage, '2');
        category.value.image = uploadedImage;
        category.refresh();

        imageUploading.value = false;
        fetchCategories();
        TFullScreenLoader.stopLoading();
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Image successfully uploaded');

      }      
      }
    } catch (e) {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }


/// --- Upload Category Imabe
Future<void>  uploadSubCategoryImage() async {
    try {
      // validate form field
      if (!imageUploadFormKey.currentState!.validate()) {
       // TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Image Name required!!');
      }else{
         //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

        // pick file and upload
        final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // start uploading image 
        TFullScreenLoader.openLoadingDialog('Processing', ITImages.docerAnimation);

     
        final uploadedImage = await categoryRepository.uploadImage('Categories/', image);
        imageUrl.value = uploadedImage;
        Map<String, dynamic> newImage = {'Image': uploadedImage};
        // conver id to int and increament by 1
        int intValue = int.parse(maxCategoryId()) + 1;
        CategoryModel categoryModel = CategoryModel(id: intValue.toString(), image: newImage['Image'],isFeatured: true, parentId: category.value.id, name: imageName.text.trim());
        await categoryRepository.saveCategoryRecord(categoryModel);
        allCategories.add(categoryModel);
        allCategories.refresh();
        
        //await categoryRepository.updateSingleField(newImage, '2');
        category.value.image = uploadedImage;
        category.refresh();

        imageUploading.value = false;
        TFullScreenLoader.stopLoading();
        TLoaders.successSnackBar(title: 'Congratulations', message: 'Image successfully uploaded');

      }      
      }
    } catch (e) {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
    }
  }

  /// Load selected category
  /// 
  
    Future<List<CategoryModel>> getSubCategories(String categoryId) async{

      try {
        final subCategory = await categoryRepository.getSubCategories(categoryId);
        return subCategory;
        
      } catch (e) {
        TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
        return [];
        
      }
  
  }
  

  /// Get category or Sub-Category
  
  Future<List<ProductModel>> getCategoryProduct({required String categoryId, int limit = 4 }) async{
    /// Fetch limited (4) products against each sub category
    
   try {
     final product = await ProductRepository.instance.getProductsForCategory(categoryId:categoryId, limit:limit);
    return product;
     
   } catch (e) {
    TLoaders.errorSnackBar(title: 'Oh Snap ', message: e.toString());
    return [];
     
   }
  }
 */

}