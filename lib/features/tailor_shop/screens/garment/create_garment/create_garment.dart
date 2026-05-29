import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/responsive_screens/create_garment_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/responsive_screens/create_garment_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/responsive_screens/create_garment_tablet.dart';


class CreateGarmentScreen extends StatelessWidget {
  const CreateGarmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateGarmentDesktopScreen(), tablet: CreateGarmentTabletScreen(), mobile: CreateGarmentMobileScreen(),);
  }
}