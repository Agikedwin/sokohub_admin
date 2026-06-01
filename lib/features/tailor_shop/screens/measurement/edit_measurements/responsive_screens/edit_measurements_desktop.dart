import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/edit_garment/widgets/edit_garment_form.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/widgets/edit_material_form.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/edit_measurements/widgets/edit_measurements_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditMeasurementDesktopScreen extends StatelessWidget {
  const EditMeasurementDesktopScreen({super.key, required this.measurement});
 
  final MeasurementModel measurement;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Measurement', breadcrumbItems: [ITRoutes.garment, 'Measurement']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditMeasurementForm(measurement: measurement,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}