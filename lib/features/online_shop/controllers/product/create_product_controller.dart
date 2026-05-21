import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/products/product_repository.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_attribute_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_variation_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product_images_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateProductController extends GetxController {

  // Singleton instance

  static CreateProductController get instance => Get.find();

  final imageController = Get.put(ProductImagesController());

  // Observable for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controller and key
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey =  GlobalKey<FormState>();

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
   TextEditingController stock = TextEditingController();
    TextEditingController price = TextEditingController();
     TextEditingController salePrice = TextEditingController();
      TextEditingController description = TextEditingController();
       TextEditingController brandTextField = TextEditingController();

  
  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;


  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
    RxBool additionalImagesUploader = false.obs;
      RxBool productDataUploader = false.obs;
        RxBool categoryRelationshipUploader = false.obs;

  Future<void> createProduct() async {
    try {
      // Show progress dialog
      showProgressDialog();

      // Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and descriptiopn
      if(!titleDescriptionFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate  stock and pricing if productType = Single 
      if(productType.value == ProductType.single && !stockPriceFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Ensure brand is selected
      if(productType.value == null) throw 'Slecte Brand for this product';

      // Check variation data if productType = variable
      if(productType.value == ProductType.variable && ProductVariationController.instance.productVariations.isEmpty){
        throw 'There are no variations for the product Type variable. Create some variations or change Product type.';
      }
      if (productType.value == ProductType.variable) {
         final invalidReason =
    ProductVariationController.instance.productVariations.map((element) {

              if (element.price.isNaN ) {
                throw 'Variation price is NaN';
              }

              if (element.price <= 0) {
                throw 'Variation price is  ${element.price}';
              }

              if (element.salePrice.isNaN) {
                throw 'Variation salePrice is NaN';
              }

              if (element.salePrice <= 0) {
                throw 'Variation salePrice is  ${element.salePrice}';
              }

              if (element.stock.isNaN) {
                throw 'Variation stock is NaN';
              }

              if (element.stock < 0) {
                throw 'Variation stock is less than 0: ${element.stock}';
              }

               if (element.image.value.isEmpty) {
                throw 'Variation image is empty'; 
              } 
               

              return null;

            }).firstWhere(
              (result) => result != null,
              orElse: () => null,
            );

            print(invalidReason);
        }

      // Upload Product Thumbnail Image
     thumbnailUploader.value = true;

     final variations = ProductVariationController.instance.productVariations;
     
         
     
     if(productType.value == ProductType.single && variations.isNotEmpty){
      // if Admin added variations and the changed the Product Type, remove all variations
      ProductVariationController.instance.resetAllValues();
      variations.value = [];
     }

     // additional image uploader
     additionalImagesUploader.value = true;

     // Map Product Data to Product Model
     final newRecord = ProductModel(
      id: '', 
      sku: '',
      isFeatured: true,
      title: title.text.trim(),
      brand: selectedBrand.value,
      productVariations: variations,
      description: description.text.trim(),
       stock: int.tryParse(stock.text.trim()) ?? 0, 
       price: double.tryParse(price.text.trim()) ?? 0, 
       images: imageController.addtionalProductImagesUrl,
       salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
       thumbnail: imageController.selectedThumnailImageUrl.value ?? '',
        productType: productType.value.name.toString(),
        productAttributes:  ProductAttributeController.instance.productAttributes,
        date: DateTime.now(),
          
          );
          
          // Call repository to create new product

          //productDataUploader.value
          productDataUploader.value = true;
          newRecord.id = await ProductRepository.instance.createProduct(newRecord);

          //Register product categories if any
          if(selectedCategories.isNotEmpty){
            if(newRecord.id!.isEmpty) throw 'Error storing data. Try again';
          }
          
          // Loop through selected Product Categories
          categoryRelationshipUploader.value = true;
          
          for(var category in selectedCategories){
            
            // Map Data
            final productCategory = ProductCategoryModel(productId: newRecord.id!, categoryId: category.id);
            await ProductRepository.instance.createProductCategory(productCategory);
          }

          // Update roduct List
          ProductController.instance.addItemTolist(newRecord);

          // Close the Progress Loader
          TFullScreenLoader.stopLoading();

          // Show completion Dialog
          showCompletionDialog();



      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      
    }
  }

  void showCompletionDialog(){
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        actions: [
          TextButton(
            onPressed: (){
              Get.back();
              Get.back();
            },
             child: const Text('Go to Products')
             )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(TImages.productsIllustration, height: 200, width: 200,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text('Congratulations', style: Theme.of(Get.context!).textTheme.headlineSmall,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const Text('Your Product has been Created')

          ],
        ),
      )
    );
  }

  /// Reset all product form fields
/// Reset all controller fields and states
void resetFields() {
  /// Loading & states
  isLoading.value = false;

  /// Product settings
  productType.value = ProductType.single;
  productVisibility.value = ProductVisibility.hidden;

  /// TextFields
  title.clear();
  stock.clear();
  price.clear();
  salePrice.clear();
  description.clear();
  brandTextField.clear();

  /// Selected data
  selectedBrand.value = null;
  selectedCategories.clear();

  /// Upload flags
  thumbnailUploader.value = false;
  additionalImagesUploader.value = false;
  productDataUploader.value = false;
  categoryRelationshipUploader.value = false;

  /// Product attributes
  ProductAttributeController.instance.productAttributes.clear();
  ProductVariationController.instance.resetAllValues();




  /// Reset form validation states
  stockPriceFormKey.currentState?.reset();
  titleDescriptionFormKey.currentState?.reset();
}

void showProgressDialog() {

      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Creating Products'),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(TImages.productsIllustration, height: 200, width: 200,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                buildCheckBox('Thumbnail Image', thumbnailUploader),
                buildCheckBox('Additional Images', additionalImagesUploader),
                buildCheckBox('Product data, Attributes & Variations', productDataUploader),
                buildCheckBox('Product Category', categoryRelationshipUploader),

                const SizedBox(height: TSizes.spaceBtwItems,),
                const Text('Sit Relax, Your product is uploading')

          ],
        ),

          ),
        ),
        
        
      );
    

}

Widget buildCheckBox(String title, RxBool value) {
  return Row(
    children: [
      AnimatedSwitcher(
        duration: const Duration(seconds: 10),
        child: value.value 
        ? const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.green,)
        : const Icon(CupertinoIcons.checkmark_alt_circle)
      ),
      const SizedBox(width: TSizes.spaceBtwItems,),
      Text(title),
    ],
  );
}


}

