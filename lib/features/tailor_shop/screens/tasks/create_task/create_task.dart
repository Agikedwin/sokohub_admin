import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/create_task/responsive_screens/create_garment_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/create_task/responsive_screens/create_task_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/create_task/responsive_screens/create_task_tablet.dart';



class CreateTasksScreen extends StatelessWidget {
  const CreateTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateTasksDesktopScreen(), tablet: CreateTasksTabletScreen(), mobile: CreateTasksMobileScreen(),);
  }
}