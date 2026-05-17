import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/responsive_screens/edit_brand_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/responsive_screens/edit_brand_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/responsive_screens/edit_brand_tablet.dart';


class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final category = Get.arguments;
   final  brand = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditBrandDesktopScreen(brand: brand ,),
      tablet: EditBrandTabletScreen(brand: brand ),
      mobile: EditBrandMobileScreen(brand: brand ),
    );
  }
}
