import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/responsive_screens/create_category_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/responsive_screens/create_category_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/responsive_screens/create_category_tablet.dart';

class CreateCategoriesScreen extends StatelessWidget {
  const CreateCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateCategoryDesktopScreen(), tablet: CreateCategoryTabletScreen(), mobile: CreateCategoryMobileScreen(),);
  }
}