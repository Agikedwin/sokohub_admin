
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      
            children: [
              //Header
              Row(
                children: [
                  IconButton(onPressed: () => Get.offAllNamed(ITRoutes.login), icon: Icon(CupertinoIcons.clear)),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwItems,),
    
              /// Image
            const Image(image: AssetImage(TImages.deliveredEmailIllustration) , width: 300, height: 300,),
            SizedBox(height: TSizes.spaceBtwItems,),
    
            /// Title and SubTitle
            Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
            SizedBox(height: TSizes.spaceBtwItems,),
            Text(email, style: Theme.of(context).textTheme.labelLarge),
            SizedBox(height: TSizes.spaceBtwItems,),
    
             Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
             SizedBox(height: TSizes.spaceBtwSections,),
    
             /// Buttons
             SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.offAllNamed(ITRoutes.login), child: const Text(TTexts.done)),
             ),
    
             SizedBox(height: TSizes.spaceBtwItems,),
    
             /// Buttons
             SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){}, child: const Text(TTexts.resendEmail)),
             )
    
    
    
            ],
          );
  }
}