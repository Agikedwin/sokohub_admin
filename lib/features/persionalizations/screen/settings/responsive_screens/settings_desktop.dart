import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/persionalizations/screen/settings/widgets/image_meta.dart';
import 'package:sokohub_admin/features/persionalizations/screen/settings/widgets/settings_form.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: false, heading: 'Setting', breadcrumbItems: ['Setting']),
              SizedBox(height: TSizes.spaceBtwSections,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(
                    child: ImageAndMeta()),

                     SizedBox(width: TSizes.spaceBtwSections,),

                    // Form
                    Expanded( flex: 2, child:  SettingsForm())

                  
                ],
              )

              

            ],
          ),
        ),
      ),
    );
  }
}