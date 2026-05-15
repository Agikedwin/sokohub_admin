import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final category = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditCategoryDesktopScreen(category: category ,),
      tablet: EditCategoryTabletScreen(category: category ),
      mobile: EditCategoryMobileScreen(category: category ),
    );
  }
}
