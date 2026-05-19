import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_attribute_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/product_variation_model.dart';
import 'package:sokohub_admin/utils/popups/dialogs.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();



   final isLoading = false.obs;
    RxList<ProductVariationModel> productVariations = <ProductVariationModel>[].obs;

    // List to store controllers for each variiation attribute
    List<Map<ProductVariationModel, TextEditingController>> stockControllerList = [];
     List<Map<ProductVariationModel, TextEditingController>> priceControllerList = [];
      List<Map<ProductVariationModel, TextEditingController>> salePriceControllerList = [];
       List<Map<ProductVariationModel, TextEditingController>> descriptionControllerList = [];


       // Instance of ProcductAttributesController
       final attributesController = Get.put(ProductAttributeController());

  
  void initializeVariationControllers(List<ProductVariationModel> variations){
    // Clear existing list
    stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();


    // Initialize controllers for each variation

  }

  void removeVariations(BuildContext context){
    TDialogs.defaultDialog(
      context: context,
      title: 'Remove Variations',
      onConfirm: (){
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      }
      );
  }



  void addNewAttribute() {

    // Form Validation

    // if(!attributeForkKey.currentState!.validate()){
    //   return;
    // }

    // Add attributes to the list of attributes
    //productAttributes.add(ProductAttributeModel(name: attributeName.text.trim(),values: attributes.text.trim().split('|').toList()), );

    // Clear text fields after adding
    //attributeName.text = '';
    //attributes.text = '';

  }

// Function to generate variation with a confirmation dialog
  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate variation',
      content: 'Once the variations are created, you cannot add mode attributes. In order to add more variations, you have to delte any of the attributes',
      onConfirm: () => generateVariationsFromAttributes(),
    
    );
  }

  void generateVariationsFromAttributes() {
  /// Close previous popup safely
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }

  final List<ProductVariationModel> variations = [];

  if (attributesController.productAttributes.isEmpty) return;

  /// Step 1: Clean attribute values safely
  final List<List<String>> attributeValues = attributesController
      .productAttributes
      .map((attr) => List<String>.from(attr.values ?? []))
      .where((e) => e.isNotEmpty)
      .toList();

  /// Step 2: Generate combinations
  final List<List<String>> attributeCombinations =
      getCombinations(attributeValues);

  print(attributeCombinations);

  /// Step 3: Attribute names
  final List<String> attributeNames = attributesController.productAttributes
      .map((attr) => attr.name ?? '')
      .toList();

  /// Step 4: Clear old controllers BEFORE generating new ones
  stockControllerList.clear();
  priceControllerList.clear();
  salePriceControllerList.clear();
  descriptionControllerList.clear();

  /// Step 5: Build variations
  for (final combination in attributeCombinations) {
    if (attributeNames.length != combination.length) continue;

    final Map<String, String> attributeValuesMap =
        Map.fromIterables(attributeNames, combination);

    final variation = ProductVariationModel(
      id: UniqueKey().toString(),
      attributeValues: attributeValuesMap,
    );

    variations.add(variation);

    /// Controllers (one per variation)
    stockControllerList.add({variation: TextEditingController()});
    priceControllerList.add({variation: TextEditingController()});
    salePriceControllerList.add({variation: TextEditingController()});
    descriptionControllerList.add({variation: TextEditingController()});
  }

  productVariations.assignAll(variations);
}
  
  void resetAllValues() {
    productVariations.clear();
     stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();

  }
  
  List<List<String>> getCombinations(List<List<String>> list) {
    // The result list that will store all combinations

    final List<List<String>> result = [];

    // Start combining attributes from the first one
    combine(list, 0, <String>[], result);

    //Return the final list of combination
    return result;

  }
  
  // Helper function to recursively combine attributes values
  // Helper function to recursively combine attributes values
  void combine(
    List<List<String>> lists,
    int index,
    List<String> current,
    List<List<String>> result,
  ) {
    /// Base case
    if (index == lists.length) {
      result.add(List<String>.from(current));
      return;
    }

    for (final item in lists[index]) {
      current.add(item);

      /// FIX: pass updated current (backtracking)
      combine(lists, index + 1, current, result);

     // current.removeLast(); // IMPORTANT BACKTRACK
    }
  }

 
 
}
