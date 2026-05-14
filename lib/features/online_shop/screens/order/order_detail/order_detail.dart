import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_desktop.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final order = Get.arguments;
    return  ITSiteLayoutTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}
