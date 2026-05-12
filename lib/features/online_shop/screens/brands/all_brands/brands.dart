import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/responsive_screens/brand_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/responsive_screens/brand_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/responsive_screens/brand_tablet.dart';


class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: BrandDesktopScreen(), tablet: BrandTabletScreen(), mobile: BrandMobileScreen(),);
  }
}