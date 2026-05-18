import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return Obx(
      () => Row(
        children: [
          Text('Product Type', style: Theme.of(context).textTheme.bodyMedium,),
          const SizedBox(width: TSizes.spaceBtwItems,),
      
          // radio buttons for single product type
          RadioMenuButton(
            value: ProductType.single,
             groupValue: controller.productType.value,
          onChanged: (value) => {
            controller.productType.value = value ?? ProductType.single
          }, 
          child: const Text('Single')),
      
          // radio buttons for variable product type
          RadioMenuButton(
            value: ProductType.variable,
             groupValue:controller.productType.value,
          onChanged: (value) => {
             controller.productType.value = value ?? ProductType.variable
          }, 
          child: const Text('Variable'))
        ],
      ),
    );
  }
}