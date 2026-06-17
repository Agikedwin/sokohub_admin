import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_accessories/responsive_screens/accessories_quantity_cost_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_accessories/responsive_screens/accessories_quantity_cost_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_accessories/responsive_screens/garment_quantity_cost_tablet.dart';





class AccessoryQuantityCostScreen extends StatelessWidget {
  const AccessoryQuantityCostScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return const ITSiteLayoutTemplate(desktop: AccessoryQuantityCostDesktopScreen(), tablet: AccessoryQuantityCostMobileScreen(), mobile: AccessoryQuantityCostTabletScreen(),);
  }
}