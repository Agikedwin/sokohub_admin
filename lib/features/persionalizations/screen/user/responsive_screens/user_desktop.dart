import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';


import 'package:sokohub_admin/features/persionalizations/screen/user/widgets/user_form.dart';
import 'package:sokohub_admin/features/persionalizations/screen/user/widgets/user_image_meta.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class UserDesktopScreen extends StatelessWidget {
  const UserDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(returnToPreviousScreen: false, heading: 'Profile', breadcrumbItems: ['Profile']),
              SizedBox(height: TSizes.spaceBtwSections,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(
                    child: UserImageMeta()),

                     SizedBox(width: TSizes.spaceBtwSections / 2,),

                    // Form
                    Expanded( flex: 2, child:  UserForm()),

                    

                  
                ],
              )

              

            ],
          ),
        ),
      ),
    );
  }
}