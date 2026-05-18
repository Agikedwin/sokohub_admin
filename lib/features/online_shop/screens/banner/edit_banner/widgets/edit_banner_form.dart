import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/create_banner_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/edit_banner_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/routes/app_screens.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;
 @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    print('=====================================================');
    print(banner.id);
    print(banner.toJson());
    controller.init(banner);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKeyEdit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Create New Banner', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Banner Name', value),
              decoration: const InputDecoration(labelText: 'Banner Name', prefixIcon: Icon(Iconsax.box)),
            ),

             const SizedBox(height: TSizes.spaceBtwSections  ,),

            // Image uploader $ Features

              Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: TImageUploader(
                        width: 80,
                        height: 80,
                        image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                        imageType: controller.imageURL.value.isNotEmpty ? ImageType.network :  ImageType.asset,
                      
                      ),
                    ),
                  ),
                   const SizedBox(height: TSizes.spaceBtwItems  ,),
                   TextButton(onPressed: () => controller.pickImage(), child: const Text('Selecte Image'))

                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields  ,),

              Text('Make your Banner Active or Inactive', style:  Theme.of(context).textTheme.bodyMedium,),
              Obx(() => CheckboxMenuButton(
                value: controller.isActive.value,
                 onChanged: (value) => controller.isActive.value = value ?? false,
                  child: const Text('Active'))),

              const SizedBox(height: TSizes.spaceBtwInputFields  ,),

              Obx(
                  () => DropdownButton<String>(
                    isExpanded: true,
                    value: AppScreens.allAppAscreenItems.contains(controller.targetScreen.value)
                        ? controller.targetScreen.value
                        : null,
                    hint: const Text('Select Target Screen'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.targetScreen.value = newValue;
                      }
                    },
                    items: AppScreens.allAppAscreenItems
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                  ),
                ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.updateBanner(banner), child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
          ],
        ),
      ),
    );
  }
  }
