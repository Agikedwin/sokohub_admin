import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_variation_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/product_attribute_model.dart';
import 'package:sokohub_admin/utils/popups/dialogs.dart';

class ProductAttributeController  extends GetxController{

   static ProductAttributeController get instance => Get.find();

   final isLoading = false.obs;
   final attributeForkKey = GlobalKey<FormState>();

   TextEditingController attributeName = TextEditingController();
   TextEditingController attributes =TextEditingController();
   RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

  void addNewAttribute() {

    // Form Validation

    if(!attributeForkKey.currentState!.validate()){
      return;
    }

    // Add attributes to the list of attributes
    productAttributes.add(ProductAttributeModel(name: attributeName.text.trim(),values: attributes.text.trim().split('|').toList()), );

    // Clear text fields after adding
    attributeName.text = '';
    attributes.text = '';

  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context){
    // Show a confirmation TDialogs

    TDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        // Reset ProductVariations when removing an attribute

        ProductVariationController.instance.productVariations.value = [];
      },
      );
  }

  //Function to reset productAttributes
  void resetProductAttributes(){
    productAttributes.clear();
  }
   
}