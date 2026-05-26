import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/edit_product_controller.dart';

import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/responsive_screens/edit_product_tablet.dart';



class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProduct(product);
    return  ITSiteLayoutTemplate(

      desktop: EditProductDesktopScreen(product: product),
      tablet: EditProductTabletScreen(product: product),
      mobile: EditProductMobileScreen(product: product),
    );
  }
}
