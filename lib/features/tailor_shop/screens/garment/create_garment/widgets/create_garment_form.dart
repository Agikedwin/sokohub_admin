import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/garment/create_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';

import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class CreateGarmentForm extends StatelessWidget {
  const CreateGarmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateGarmentController());
    final materialController = Get.put(GarmentController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Create New Garment', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: createController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Garment Name', prefixIcon: Icon(Iconsax.bag_2)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

            
            TextFormField(
              controller: createController.wage,
              validator: (value) => TValidator.validateEmptyText('Wage', value),
              decoration: const InputDecoration(labelText: 'Fundi Wage', prefixIcon: Icon(Iconsax.money)),
               keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),             

             

               Obx(
                 () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: createController.imageURL.isNotEmpty ? createController.imageURL.value :TImages.defaultImage,
                  imageType: createController.imageURL.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => createController.pickImage(),
                 ),
               ),
                 const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),

                 Obx(
                   () => CheckboxMenuButton(
                    value: createController.isFeatured.value,
                    onChanged: (value) => createController.isFeatured.value = value ?? false, 
                    child: const Text('Featured')),
                 ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => createController.createGarment(), child: const Text('Create')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
}