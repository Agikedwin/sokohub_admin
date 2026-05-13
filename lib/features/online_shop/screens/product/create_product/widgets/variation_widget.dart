import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Product variation Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product variation', style: Theme.of(context).textTheme.headlineSmall,),
              TextButton(onPressed: (){}, child: const Text('Remove variation')),

            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems,),

          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwItems,),
            itemBuilder: (_,index){
              return _buildVariationTile();
            },             
              itemCount: 3
              ),

              _buildVariationMessage()
        ],
        
      ),
    );
  }

// Helper method to build a variation tile
  Widget _buildVariationTile(){
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(TSizes.borderRadiusLg)),
      title: const Text('Color: Green, size: Small'),
      children: [
        // Uloade variation Image

        Obx(
          () => TImageUploader(
            imageType: ImageType.asset, 
            right: 0, left: null,
             image: TImages.defaultImage,
             onIconButtonPressed: (){},
          )
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields,),

        Row(
          children: [
            Expanded(
              child:   TextFormField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Stock', hintText: 'Add Atock, only numbers are allowed'),
              validator: (value) => TValidator.validateEmptyText('Stock', value),
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

            ),
            
            ),
            SizedBox(width: TSizes.spaceBtwInputFields,),
            Expanded(
                child: TextFormField(
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
              
              decoration: const InputDecoration(
                labelText: 'Product Description',
                hintText: 'Add your product description here ...',
              ),
            ),

            SizedBox(width: TSizes.spaceBtwSections,),
      ],
    );

  }
  
 Widget _buildVariationMessage() {
  return const Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TRoundedImage(imageType: ImageType.asset, height: 200, width: 200, image: TImages.defaultAttributeColorsImageIcon,)
        ],
      ),
       SizedBox(height: TSizes.spaceBtwItems,),
       Text('There are no variations added for this product'),

    ],
  );
 }
}