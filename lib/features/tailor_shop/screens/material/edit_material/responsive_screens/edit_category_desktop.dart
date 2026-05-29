import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/widgets/edit_category_form.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/widgets/edit_material_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditMaterialDesktopScreen extends StatelessWidget {
  const EditMaterialDesktopScreen({super.key, required this.material});
 
  final MaterialModel material;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Material', breadcrumbItems: [ITRoutes.material, 'Material']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditMaterialForm(material: material,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}