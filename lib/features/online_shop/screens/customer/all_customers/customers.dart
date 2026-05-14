
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/responsive_screens/customer_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/responsive_screens/customer_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/responsive_screens/customer_tablet.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CustomerDesktopScreen(), tablet: CustomerTabletScreen(), mobile: CustomerMobileScreen(),);
  }
}