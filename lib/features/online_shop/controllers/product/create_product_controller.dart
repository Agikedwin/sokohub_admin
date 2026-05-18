import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/products/product_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class CreateProductController extends GetxController {

  // Singleton instance

  static CreateProductController get instance => Get.find();

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
  final Rx<CategoryModel?> selectedCategories = Rx<CategoryModel?>(null);


}