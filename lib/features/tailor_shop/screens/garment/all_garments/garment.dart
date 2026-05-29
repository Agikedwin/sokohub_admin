import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/responsive_screens/garment_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/responsive_screens/garment_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/responsive_screens/garment_tablet.dart';


class GarmentScreen extends StatelessWidget {
  const GarmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: GarmentDesktopScreen(), tablet: GarmentTabletScreen(), mobile: GarmentMobileScreen(),);
  }
}