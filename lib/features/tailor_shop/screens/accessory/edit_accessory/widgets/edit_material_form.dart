import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/edit_accessory_controller.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/material/edit_material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditAccessoryForm extends StatelessWidget {
  const EditAccessoryForm({super.key, required this.accessory});

  final AccessoryModel accessory;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditAccessoryController());    
    editController.init(accessory);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Create New Accessory', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: editController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Accessory Name', prefixIcon: Icon(Iconsax.category)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),


             TextFormField(
              controller: editController.unitCost,
              validator: (value) => TValidator.validateEmptyText('Unit Cost', value),
              decoration: const InputDecoration(labelText: 'Unit Cost', prefixIcon: Icon(Iconsax.money)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

             

               Obx(
                 () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: editController.imageURL.isNotEmpty ? editController.imageURL.value :TImages.defaultImage,
                  imageType: editController.imageURL.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => editController.pickImage(),
                 ),
               ),
                 const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),

                 Obx(
                   () => CheckboxMenuButton(
                    value: editController.isFeatured.value,
                    onChanged: (value) => editController.isFeatured.value = value ?? false, 
                    child: const Text('Featured')),
                 ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => editController.updateAccessory(accessory), child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
  }
