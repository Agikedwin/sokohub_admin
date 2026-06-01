import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/create_measuremnt_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';

import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class CreateMeasurementForm extends StatelessWidget {
  const CreateMeasurementForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateMeasurementController());
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
            Text('Create New Measurement', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: createController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Measurement Name', prefixIcon: Icon(Iconsax.bag_2)),
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
                    child: ElevatedButton(onPressed: () => createController.createMeasurement(), child: const Text('Create')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
}