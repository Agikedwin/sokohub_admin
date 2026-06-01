import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/responsive_screens/accessory_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/responsive_screens/accessory_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/responsive_screens/accessory_tablet.dart';


class AccessoryScreen extends StatelessWidget {
  const AccessoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: AccessoryDesktopScreen(), tablet: AccessoryTabletScreen(), mobile: AccessoryMobileScreen(),);
  }
}