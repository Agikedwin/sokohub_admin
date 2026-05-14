
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/responsive_screens/order_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/responsive_screens/order_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/responsive_screens/order_tablet.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: OrderDesktopScreen(), tablet: OrderTabletScreen(), mobile: OrderMobileScreen(),);
  }
}