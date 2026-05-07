
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';

class ResetHeaderAndForm extends StatelessWidget {
  const ResetHeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
            children: [
              // Header
              IconButton(onPressed: ()=> Get.back(), icon: Icon(Iconsax.arrow_left)),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: TSizes.spaceBtwItems,),
               Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium,),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
    
              // Form
              Form(
                child: TextFormField(
                  decoration:  InputDecoration(
                    labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              
              /// Sunmit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.toNamed(ITRoutes.resetPassword, parameters: {'email':'agikedwin@gmail.com'}), child: Text(TTexts.submit) ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
    
            ],
          );
  }
}
