import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/tasks/all_tasks/responsive_screens/task_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/all_tasks/responsive_screens/task_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/all_tasks/responsive_screens/task_tablet.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: TasksDesktopScreen(), tablet: TasksTabletScreen(), mobile: TasksMobileScreen(),);
  }
}