import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/edit_accessory/responsive_screens/edit_accessory_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/edit_accessory/responsive_screens/edit_accessory_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/edit_accessory/responsive_screens/edit_accessory_tablet.dart';



class EditAccessoryScreen extends StatelessWidget {
  const EditAccessoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final accessory = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditAccessoryDesktopScreen(accessory: accessory ,),
      tablet: EditAccessoryTabletScreen(accessory: accessory ),
      mobile: EditAccessoryMobileScreen(accessory: accessory ),
    );
  }
}
