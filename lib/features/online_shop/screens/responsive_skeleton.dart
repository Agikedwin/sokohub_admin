import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/dashboard_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/dashboard_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/dashboard_tablet.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(
      desktop: DashboardDestopScreen(),  // DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),
    );
  }
}
