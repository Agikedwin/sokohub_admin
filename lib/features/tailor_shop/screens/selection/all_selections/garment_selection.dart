import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/all_selections/responsive_screens/garment_selection_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/all_selections/responsive_screens/garment_selection_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/all_selections/responsive_screens/garment_selection_tablet.dart';



class GarmentSelectionScreen extends StatelessWidget {
  const GarmentSelectionScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    
    return const ITSiteLayoutTemplate(desktop: GarmentSelectionDesktopScreen(), tablet: GarmentSelectionTabletScreen(), mobile: GarmentSelectionMobileScreen(),);
  }
}