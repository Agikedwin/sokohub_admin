import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/create_category_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateMaterialMobileScreen extends StatelessWidget {
  const CreateMaterialMobileScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Material', breadcrumbItems: [ITRoutes.createCategory, 'Create Material']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateCategoryForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}