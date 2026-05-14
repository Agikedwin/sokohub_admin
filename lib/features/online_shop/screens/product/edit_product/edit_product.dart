import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';

import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_tablet.dart';



class EEditProductScreen extends StatelessWidget {
  const EEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final category = Get.arguments;
   final  banner = BannerModel(name: '', imageUrl: '', active: true, targetScreen: '');
    return  ITSiteLayoutTemplate(

      desktop: EditProductDesktopScreen(banner: banner ,),
      tablet: EditProductTabletScreen(banner: banner ),
      mobile: EditProductMobileScreen(banner: banner ),
    );
  }
}
