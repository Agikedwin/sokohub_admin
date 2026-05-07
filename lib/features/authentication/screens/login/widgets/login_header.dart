
import 'package:flutter/material.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';

class ITLoginHeader extends StatelessWidget {
  const ITLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(width: 100, height: 100, image: AssetImage(TImages.darkAppLogo)),
          SizedBox(height: TSizes.spaceBtwSections,),
          Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: TSizes.sm,),
          Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    
    );
  }
}