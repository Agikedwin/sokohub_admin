import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/persionalizations/screen/profile/widgets/image_meta.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/widgets/profile_form.dart';
import 'package:sokohub_admin/features/persionalizations/screen/user/user.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class UserMobileScreen extends StatelessWidget {
  const UserMobileScreen({super.key});

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

              //UserScreen(),
              
                 SizedBox(width: TSizes.spaceBtwSections,),
              
                // Form
               // UserScreen()

              

            ],
          ),
        ),
      ),
    );
  }
}