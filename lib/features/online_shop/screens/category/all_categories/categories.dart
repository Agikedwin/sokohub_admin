import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/responsive_screens/category_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/responsive_screens/category_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/responsive_screens/category_tablet.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CategoryDesktopScreen(), tablet: CategoryTabletScreen(), mobile: CategoryMobileScreen(),);
  }
}