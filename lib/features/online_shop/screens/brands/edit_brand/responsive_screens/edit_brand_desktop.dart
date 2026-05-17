import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});
 
  final BrandModel brand;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Brand', breadcrumbItems: [ITRoutes.categories, 'Update Brand']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditBrandForm(brand: brand,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}