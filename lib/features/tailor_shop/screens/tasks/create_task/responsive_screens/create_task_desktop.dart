import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/widgets/create_garment_form.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/create_task/widgets/create_task_form.dart';

import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateTasksDesktopScreen extends StatelessWidget {
  const CreateTasksDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Create Tasks', breadcrumbItems: [ITRoutes.categories, 'Create Tasks']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
               CreateTasksForm(),

             

              

            ],
          ),
        ),
      ),
    );
  }
}