import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/edit_task/widgets/edit_task_form.dart';

import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditTasksDesktopScreen extends StatelessWidget {
  const EditTasksDesktopScreen({super.key, required this.task});
 
  final TaskModel task;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Tasks', breadcrumbItems: [ITRoutes.task, 'Tasks']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditTasksForm(task: task,)
              

              

            ],
          ),
        ),
      ),
    );
  }
}