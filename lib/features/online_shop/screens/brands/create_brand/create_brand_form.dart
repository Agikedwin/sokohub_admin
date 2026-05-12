import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

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
            Text('Create New Category', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

             DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: 'Parent Category',
                labelText: 'Parent Category',
                prefixIcon: Icon(Iconsax.bezier),
              ),
               onChanged: (newValue){},
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('item.name')],),
                )
              ],
              
              ),
               const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),

               TImageUploader(
                width: 80,
                height: 80,
                image: TImages.defaultImage,
                imageType: ImageType.asset,
                onIconButtonPressed: () =>{},
               ),
                 const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),

                 CheckboxMenuButton(value: true, onChanged: (value){}, child: const Text('Featured')),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: const Text('Create')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
}