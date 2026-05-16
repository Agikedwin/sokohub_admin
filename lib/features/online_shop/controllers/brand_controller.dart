import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/brand/brand_repository.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';



class BrandController extends TBaseController<BrandModel>{

  static BrandController get instance => Get.find();

   final brandRepository = Get.put(BrandRepository());

  final categoryController = Get.put(CategoryController());



  @override
  Future<List<BrandModel>> fetchItems()  async{
    // Fetch brands
    final fetchedBrands = await brandRepository.getAllBrands();
    print('----------');
    print(fetchedBrands.toList());

    // Fetch brand category from relation Data
    final fetchBrandCategiries = await brandRepository.getAllBrandForCategory();

     print('----------2');
    print(fetchBrandCategiries.toList());

     // Fetch brand categories is data not already exixt
     if(categoryController.allItems.isEmpty) await categoryController.fetchItems();

    // loop all brands and fetch categories of eacg
    for(var brand in fetchedBrands){
      print('----------2');
    print(brand.toJson());
      //Extract categoryIds from the document
      List<String> categoryIds = fetchBrandCategiries
      .where((brandCategory) => brandCategory.brandId == brand.id)
      .map((brandCategory) => brandCategory.categoryId).toList();

      brand.brandCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
    }
    print('&&&&&&&&&&&');
    print(fetchedBrands.length);
    return fetchedBrands;
  }
  
  
  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(BrandModel item) async{
    throw UnimplementedError();
  }



  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
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