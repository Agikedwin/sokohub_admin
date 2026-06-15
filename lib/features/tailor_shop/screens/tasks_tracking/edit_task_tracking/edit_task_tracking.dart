import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';


import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/edit_task_tracking/responsive_screens/edit_task_tracking_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/edit_task_tracking/responsive_screens/edit_task_tracking_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/edit_task_tracking/responsive_screens/edit_task_tracking_tablet.dart';


class EditTaskTrackingScreen extends StatelessWidget {
  const EditTaskTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final category = Get.arguments;
   ClientSelectionAttributesModel tasks = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditTaskTrackingDesktopScreen(tasks: tasks ,),
      tablet: EditTaskTrackingTabletScreen(tasks: tasks ),
      mobile: EditTaskTrackingMobileScreen(tasks: tasks ),
    );
  }
}
