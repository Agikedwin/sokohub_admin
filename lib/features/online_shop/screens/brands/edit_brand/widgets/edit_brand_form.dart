import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/chips/rounded_choice_chips.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/edit_category_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Update Brand', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Brand Name', value),
              decoration: const InputDecoration(labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

             // Categories

             Text('Select Categories', style:  Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),

             Obx(
               () => Wrap(
                spacing: TSizes.sm,
                children: CategoryController.instance.allItems
                .map((category) =>  Padding(
                    padding: EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(text: category.name, 
                    selected: controller.selectedCategories.contains(category),
                     onSelected: (value)=> controller.toggleSelection(category),),
                  ),                
                ).toList()
               ),
             ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),

              Obx(
                () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                  imageType: controller.imageURL.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
                
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields  ,),

               Obx(() => CheckboxMenuButton(
                value: controller.isFeatured.value, 
                onChanged: (value){
                  print(value);
                  controller.isFeatured.value = value ?? false;
                  print(controller.isFeatured.value);
                }, 
                child: const Text('Featured'))
                ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.updateBrand(brand), 
                    child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
          ],
        ),
      ),
    );
  }
  }
  
