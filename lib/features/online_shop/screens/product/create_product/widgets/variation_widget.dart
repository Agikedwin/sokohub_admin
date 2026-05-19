import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_variation_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product_images_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/product_variation_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});
  

  @override
  Widget build(BuildContext context) {
    final variationController = ProductVariationController.instance;
    return Obx(
      () => CreateProductController.instance.productType.value == ProductType.variable 
      ?  TRoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
            // Product variation Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product variation', style: Theme.of(context).textTheme.headlineSmall,),
                TextButton(onPressed: () => variationController.removeVariations(context),
                 child: const Text('Remove variation')),
      
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems,),

            if(variationController.productVariations.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwItems,),
              itemBuilder: (_,index){
                final variation = variationController.productVariations[index];
                return _buildVariationTile(context, index, variation, variationController);
              },             
                itemCount: variationController.productVariations.length,
                )
              else      
                _buildNoVariationMessage()
          ],
          
        ),
      ) : const SizedBox.shrink(),
    );
  }

// Helper method to build a variation tile
  Widget _buildVariationTile(BuildContext contex, int index, ProductVariationModel variation, ProductVariationController variationController){
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(TSizes.borderRadiusLg)),
      title: Text(variation.attributeValues.entries.map((entry) => '${entry.key} : ${entry.value}').join(', ')),
      children: [
        // Upload variation Image

        Obx(
          () => TImageUploader(
            imageType: variation.image.value.isNotEmpty ? ImageType.network : ImageType.asset,
            right: 0, left: null,
             image: variation.image.value.isNotEmpty ? variation.image.value : TImages.defaultImage,
             onIconButtonPressed: () => ProductImagesController.instance.selectVariationImage(variation),
          )
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields,),

        // Variation Stock, and Pricing

        Row(
          children: [
            Expanded(
              child:   TextFormField(
                controller: variationController.stockControllerList[index][variation],
                onChanged: (value) => variation.stock = int.parse(value),
                
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Stock', hintText: 'Add Atock, only numbers are allowed'),
              validator: (value) => TValidator.validateEmptyText('Stock', value),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

            ),
            
            ),
            SizedBox(width: TSizes.spaceBtwInputFields,),
            Expanded(
                child: TextFormField(
                  controller: variationController.priceControllerList[index][variation],
                onChanged: (value) => variation.price = double.parse(value),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price up to 2 decimals',
                  ),
                  validator: (value) =>
                      TValidator.validateEmptyText('Price', value),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}$'),
                    ),
                  ],
                ),
              ),
               SizedBox(width: TSizes.spaceBtwInputFields,),

              Expanded(
              child: TextFormField(
                controller: variationController.salePriceControllerList[index][variation],
                onChanged: (value) => variation.salePrice = double.parse(value),
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price up to 2 decimals',
                ),
                validator: (value) =>
                    TValidator.validateEmptyText('Price', value),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,2}$'),
                  ),
                ],
              ),
            )
          ],
        ),

        SizedBox(width: TSizes.spaceBtwInputFields,),
        // Variation Description

        TextFormField(
          controller: variationController.descriptionControllerList[index][variation],
          onChanged: (value) => variation.description = value,              
              decoration: const InputDecoration(
                labelText: 'Product Description',
                hintText: 'Add your product description here ...',
              ),
            ),

            SizedBox(width: TSizes.spaceBtwSections,),
      ],
    );

  }
  
 Widget _buildNoVariationMessage() {
  return const Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TRoundedImage(imageType: ImageType.asset, height: 200, width: 200, image: TImages.defaultVariationImageIcon,)
        ],
      ),
       SizedBox(height: TSizes.spaceBtwItems,),
       Text('There are no variations added for this product'),

    ],
  );
 }
}