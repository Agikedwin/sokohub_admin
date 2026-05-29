import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/responsive_screens/category_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/responsive_screens/category_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/responsive_screens/category_tablet.dart';

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: MaterialDesktopScreen(), tablet: MaterialTabletScreen(), mobile: MaterialMobileScreen(),);
  }
}