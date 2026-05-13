import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Update Banner', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              validator: (value) => TValidator.validateEmptyText('Brand Name', value),
              decoration: const InputDecoration(labelText: 'Brand Name', prefixIcon: Icon(Iconsax.box)),
            ),

             const SizedBox(height: TSizes.spaceBtwSections  ,),

            // Image uploader $ Features

              Column(
                children: [
                  GestureDetector(
                    child: TImageUploader(
                      width: 80,
                      height: 80,
                      image: TImages.defaultImage,
                      imageType: ImageType.asset,
                      onIconButtonPressed: () => {},
                    
                    ),
                  ),
                   const SizedBox(height: TSizes.spaceBtwItems  ,),
                   TextButton(onPressed: (){}, child: const Text('Selecte Image'))

                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields  ,),

              Text('Make your Banner Active or Inactive', style:  Theme.of(context).textTheme.bodyMedium,),
              CheckboxMenuButton(value: true, onChanged: (value) =>{}, child: const Text('Active')),

              const SizedBox(height: TSizes.spaceBtwInputFields  ,),

              DropdownButton<String>(value: 'search',  onChanged: (String? newValue){}, items: const [
                DropdownMenuItem<String>(value: 'home', child:  Text('Home')),
                DropdownMenuItem<String>(value: 'search',  child:  Text('Search')),
              ],),
               const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),



                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
          ],
        ),
      ),
    );
  }
  }
