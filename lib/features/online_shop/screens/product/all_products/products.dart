import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/online_shop/screens/product/all_products/responsive_screens/product_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/responsive_screens/product_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/responsive_screens/product_tablet.dart';



class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: ProductDesktopScreen(), tablet: ProductTabletScreen(), mobile: ProductMobileScreen(),);
  }
}