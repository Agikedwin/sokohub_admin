import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/edit_accessory/widgets/edit_material_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditAccessoryDesktopScreen extends StatelessWidget {
  const EditAccessoryDesktopScreen({super.key, required this.accessory});
 
  final AccessoryModel accessory;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Accessory', breadcrumbItems: [ITRoutes.accessory, 'Accessory']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditAccessoryForm(accessory: accessory,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}