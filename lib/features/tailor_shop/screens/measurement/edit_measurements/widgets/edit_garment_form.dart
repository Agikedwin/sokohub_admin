import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/edit_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/material/edit_material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditGarmentForm extends StatelessWidget {
  const EditGarmentForm({super.key, required this.garment});

  final GarmentModel garment;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditGarmentController());    
    editController.init(garment);
     final materialController = Get.put(GarmentController());
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
            Text('Create New Garment', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: editController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Garment Name', prefixIcon: Icon(Iconsax.category)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),


            TextFormField(
              controller: editController.wage,
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
                    child: ElevatedButton(onPressed: () => editController.updateGarment(garment), child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
  }
