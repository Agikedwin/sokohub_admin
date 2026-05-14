import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/responsive_screens/customer_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/responsive_screens/customer_mobile.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final customer = Get.arguments;
    return  ITSiteLayoutTemplate(
      desktop: CustomerDetailDesktopScreen(),
      mobile: CustomerDetailMobileScreen(),
    );
  }
}
