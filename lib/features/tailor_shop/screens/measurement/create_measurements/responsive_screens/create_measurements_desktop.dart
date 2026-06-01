import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/create_measurements/widgets/create_measurements_form.dart';

import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateMeasurementDesktopScreen extends StatelessWidget {
  const CreateMeasurementDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Measurement', breadcrumbItems: [ITRoutes.categories, 'Create Measurement']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateMeasurementForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}