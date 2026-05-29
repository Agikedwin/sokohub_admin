import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/widgets/create_garment_form.dart';

import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateGarmentDesktopScreen extends StatelessWidget {
  const CreateGarmentDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Garment', breadcrumbItems: [ITRoutes.categories, 'Create Garment']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateGarmentForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}