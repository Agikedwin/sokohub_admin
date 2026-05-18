
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProductAttributesWidget extends StatelessWidget {
  const ProductAttributesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
     final productController = CreateProductController.instance;
     //final attributeController = Get.put(ProductAttributeController());
    // final variationController = Get.put(ProductVariationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx((){
          return productController.productType.value == ProductType.single
          ? const Column(
            children: [
               Divider(color: TColors.primaryBackground,),
               SizedBox(height: TSizes.spaceBtwItems,),
            ],
          ): SizedBox.shrink();
        }),
        Text('Add Product Attributes', style:  Theme.of(context).textTheme.headlineSmall,),
         const SizedBox(height: TSizes.spaceBtwItems,),
        
        //Form to add new attributes
        Form(
          //key: ,
          child: TDeviceUtils.isDesktopScreen(context) 
          ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildAttributeName()),
                 const SizedBox(width: TSizes.spaceBtwInputFields),


               Expanded(
                flex: 2,
                child: _buildAttributeTextField(),
               ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),

                 _buildAttributeTextButton()
            ],
          ): Column(
            children: [
               _buildAttributeName(),
                 const SizedBox(width: TSizes.spaceBtwInputFields),


               _buildAttributeTextField(),
                const SizedBox(height: TSizes.spaceBtwItems,),
                 _buildAttributeTextButton()
            ],
          ),
        ),
      SizedBox(height: TSizes.spaceBtwSections,),
      // List of added attributes
      Text('All Attributes', style: Theme.of(context).textTheme.headlineSmall,),
      SizedBox(height: TSizes.spaceBtwItems,),

      // Display added attributes in a rounded container
            
      TRoundedContainer(
        backgroundColor: TColors.borderPrimary,
        child: Column(
          children: [
            buildAttributesList(context),
            buildEmptyAttributes()
          ],
        ),

      ),
       SizedBox(height: TSizes.spaceBtwItems,),

       // Generate variations
       Center(
        child: SizedBox(
          width: 200,
          child: ElevatedButton.icon(onPressed: (){}, label: const Text('Generate Variation'), icon: Icon(Iconsax.activity),),
        ),
       )


      // 

     
      ],
    );
  }
  
 Column buildEmptyAttributes() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TRoundedImage(imageType: ImageType.asset, width: 150, image: TImages.defaultAttributeColorsImageIcon,)
        ],
      )
    ],
  );
 }
}
ListView buildAttributesList(BuildContext context) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 3,
    separatorBuilder: (_, __) =>
        const SizedBox(height: TSizes.spaceBtwItems),
    itemBuilder: (_, index) {
      return Container(
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(
            TSizes.borderRadiusLg,
          ),
        ),
        child: ListTile(
          title: const Text('Color'),
          subtitle: const Text(
            'Green, Orange, Pink',
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.trash,
              color: TColors.error,
            ),
          ),
        ),
      );
    },
  );
}


// add a new attribute 
SizedBox _buildAttributeTextButton() {
  return SizedBox(
    width: 100,
    child: ElevatedButton.icon(onPressed: (){},
    icon: const Icon(Iconsax.add),
    style: ElevatedButton.styleFrom(
      foregroundColor: TColors.black,
      backgroundColor: TColors.primary

    ),
     label: const Text('Add')),
  );
}


// attribute name

TextFormField _buildAttributeName () {
  return TextFormField(
    validator: (value) => TValidator.validateEmptyText('Attribute name', value),
    decoration: const InputDecoration(labelText: 'Attribute Name', hintText: 'Colors, Size, Material'),
  );
}

SizedBox _buildAttributeTextField() {
  return SizedBox(
    height: 80,
    child: TextFormField(
      expands: true,
      maxLines: null,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      decoration: const InputDecoration(
        labelText: 'Attributes',
        hintText: 'Add Attributes bt | Example Green | Blue | Yellow',
        alignLabelWithHint: true
      ),
    ),

  );
}