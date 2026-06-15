import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/create_brand_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateBrandMobileScreen extends StatelessWidget {
  const CreateBrandMobileScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Brand', breadcrumbItems: [ITRoutes.createCategory, 'Create Brand']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateBrandForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}