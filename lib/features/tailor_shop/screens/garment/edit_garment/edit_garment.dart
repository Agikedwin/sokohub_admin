import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/edit_garment/responsive_screens/edit_garment_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/edit_garment/responsive_screens/edit_garment_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/edit_garment/responsive_screens/edit_garment_tablet.dart';



class EditGarmentScreen extends StatelessWidget {
  const EditGarmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final garment = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditGarmentDesktopScreen(garment: garment ,),
      tablet: EditGarmentTabletScreen(garment: garment ),
      mobile: EditGarmentMobileScreen(garment: garment ),
    );
  }
}
