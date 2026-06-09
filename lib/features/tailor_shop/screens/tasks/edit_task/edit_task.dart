import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/edit_task/responsive_screens/edit_task_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/edit_task/responsive_screens/edit_task_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/edit_task/responsive_screens/edit_task_tablet.dart';




class EditTasksScreen extends StatelessWidget {
  const EditTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final task = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditTasksDesktopScreen(task: task ,),
      tablet: EditTasksTabletScreen(task: task ),
      mobile: EditTasksMobileScreen(task: task ),
    );
  }
}
