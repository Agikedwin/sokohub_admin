import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/responsive_screens/banner_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/responsive_screens/banner_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/responsive_screens/banner_tablet.dart';



class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: BannerDesktopScreen(), tablet: BannerTabletScreen(), mobile: BannerMobileScreen(),);
  }
}