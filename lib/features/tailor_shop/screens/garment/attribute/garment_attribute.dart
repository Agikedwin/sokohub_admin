import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/responsive_screens/garment_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/responsive_screens/garment_attributes_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/responsive_screens/garment_attributes_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/responsive_screens/garment_attributes_tablet.dart';

class GarmentAttributeScreen extends StatelessWidget {
  const GarmentAttributeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garment = Get.arguments;
    return ITSiteLayoutTemplate(desktop: GarmentAttributesDesktopScreen(garment: garment), tablet: GarmentAttributesTabletScreen(), 
    mobile: GarmentAttributesMobileScreen());
  }
}