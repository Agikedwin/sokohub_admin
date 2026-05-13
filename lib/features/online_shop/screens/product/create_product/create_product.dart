

import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/online_shop/screens/product/create_product/responsive_screens/create_product_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/responsive_screens/create_product_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/responsive_screens/create_product_tablet.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateProductDesktopScreen(), tablet: CreateProductTabletScreen(), mobile: CreateProductMobileScreen(),);
  }
}