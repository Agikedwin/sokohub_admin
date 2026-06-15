import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/all_tasks_tracking/responsive_screens/tasks_tracking_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/all_tasks_tracking/responsive_screens/tasks_tracking_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/all_tasks_tracking/responsive_screens/tasks_tracking_tablet.dart';


class TasksTrackingScreen extends StatelessWidget {
  const TasksTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tracking = Get.arguments;
    return  ITSiteLayoutTemplate(desktop: TasksTrackingDesktopScreen(tracking: tracking), tablet: TasksTrackingTabletScreen(), mobile: TasksTrackingMobileScreen(),);
  }
}