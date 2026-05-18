import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProductTitleDescription extends StatelessWidget {
  const ProductTitleDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProductController());
    return TRoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text

            Text('Basic Information', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // Product Title Input Field
          TextFormField(
            controller: controller.title,
            validator: (value) => TValidator.validateEmptyText('Product Title', value),
            decoration: const InputDecoration(labelText: 'Product Title'),

          ),
           SizedBox(height: TSizes.spaceBtwItems,),

           SizedBox(
            
            height: 300,
            child: TextFormField(
              controller: controller.description,
              expands: true,
              maxLines: null,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              validator: (value) => TValidator.validateEmptyText('Product Description', value),
              decoration: const InputDecoration(
                labelText: 'Product Description',
                hintText: 'Add your product description here ...',
                alignLabelWithHint: true
              ),
            ),
           )
          ],
        ),
      ),
    );
  }
}