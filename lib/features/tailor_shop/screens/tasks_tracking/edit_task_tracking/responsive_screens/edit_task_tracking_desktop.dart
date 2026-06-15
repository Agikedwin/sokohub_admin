import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/edit_task_tracking/widgets/edit_task_tracking_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditTaskTrackingDesktopScreen extends StatelessWidget {
  const EditTaskTrackingDesktopScreen({super.key, required this.tasks});
 
  final ClientSelectionAttributesModel tasks;

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
              EditTaskTrackingForm(tasks: tasks,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}