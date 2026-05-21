import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    for(var variation in variations){
      //Stock Controller
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] = TextEditingController(text: variation.stock.toString());
      stockControllerList.add(stockControllers);

      //Price Controller
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] = TextEditingController(text: variation.price.toString());
      priceControllerList.add(priceControllers);


      //Sale Price Controller
      Map<ProductVariationModel, TextEditingController> salePriceControllers = {};
      salePriceControllers[variation] = TextEditingController(text: variation.salePrice.toString());
      salePriceControllerList.add(salePriceControllers);

      //Sale Price Controller
      Map<ProductVariationModel, TextEditingController> descriptionControllers = {};
      descriptionControllers[variation] = TextEditingController(text: variation.description.toString());
      descriptionControllerList.add(descriptionControllers);


      update();
    }

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
   Get.back();
   print('----------------1');

  final List<ProductVariationModel> variations = [];

  if (attributesController.productAttributes.isNotEmpty){
  // Create all combinations of attributes of values[[Green, Blue], [Small,Large]]

  final List<List<String>> attributeCombinations =  
      getCombinations(attributesController.productAttributes.map((attr) => attr.values ?? <String>[]).toList());
  

  // generate ProductVariationModel for each combination
  for (final combination in attributeCombinations) {

    final Map<String, String> attributeValues =
        Map.fromIterables(attributesController.productAttributes.map((attr) => attr.name ?? ''), combination);

    // You can set default values for other properties if needed
    final ProductVariationModel variation = ProductVariationModel(id: UniqueKey().toString(),attributeValues: attributeValues);

    variations.add(variation);

    /// create Controllers (one per variation)
    final Map<ProductVariationModel, TextEditingController> stockController = {};
    final Map<ProductVariationModel, TextEditingController> priceController = {};
    final Map<ProductVariationModel, TextEditingController> salePriceController = {};
    final Map<ProductVariationModel, TextEditingController> descriptionController = {};  


    // Assuming variation is your current ProductVariationModel
    stockController[variation] = TextEditingController();
    priceController[variation] = TextEditingController();
    salePriceController[variation] = TextEditingController();
    descriptionController[variation] = TextEditingController();

    // Add the Maps to their respective lists
    stockControllerList.add(stockController);
    priceControllerList.add(priceController);
    salePriceControllerList.add(salePriceController);
    descriptionControllerList.add(descriptionController);
  
  }

  }
  
  // Assign the generated variations to the productVariation list
  productVariations.assignAll(variations);
}
  
  void resetAllValues() {
    productVariations.clear();
     stockControllerList.clear();
    priceControllerList.clear();
    salePriceControllerList.clear();
    descriptionControllerList.clear();

  }
  
  List<List<String>> getCombinations(List<List<String>> lists) {
    // The result list that will store all combinations

    final List<List<String>> result = [];

    // Start combining attributes from the first one
    combine(lists, 0, <String>[], result);

    //Return the final list of combination
    return result;

  }
  
  // Helper function to recursively combine attributes values
  // Helper function to recursively combine attributes values
  void combine(List<List<String>> lists,int index, List<String> current, List<List<String>> result ) {
    /// If we have readhed the end of this list, add the current combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    //Iterate over the values of the current attribute
    for (final item in lists[index]) {
      // Create an updated list with the current value add
      final List<String> updated = List.from(current)..add(item);

      /// Recursively combine with the next attribute
      combine(lists, index + 1, updated, result);

     // current.removeLast(); // IMPORTANT BACKTRACK
    }
  }

 
 
}
