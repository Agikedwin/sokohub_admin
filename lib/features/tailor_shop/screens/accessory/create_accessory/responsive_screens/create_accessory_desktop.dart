import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/create_accessory/widgets/create_accessory_form.dart';


import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateAccessoryDesktopScreen extends StatelessWidget {
  const CreateAccessoryDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Accessory', breadcrumbItems: [ITRoutes.categories, 'Create Accessory']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateAccessoryForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}