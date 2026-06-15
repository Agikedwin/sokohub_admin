import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/responsive_screens/create_brand_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/responsive_screens/create_brand_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/responsive_screens/create_brand_tablet.dart';


class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateBrandDesktopScreen(), tablet: CreateBrandTabletScreen(), mobile: CreateBrandMobileScreen(),);
  }
}