import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/edit_banner/responsive_screens/edit_banner_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/edit_banner/responsive_screens/edit_banner_tablet.dart';



class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // final category = Get.arguments;
   final  banner = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditBannerDesktopScreen(banner: banner ,),
      tablet: EditBannerTabletScreen(banner: banner ),
      mobile: EditBannerMobileScreen(banner: banner ),
    );
  }
}
