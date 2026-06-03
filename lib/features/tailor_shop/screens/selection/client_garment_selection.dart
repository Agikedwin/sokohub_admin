import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/responsive_screens/garment_selection_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/responsive_screens/garment_selection_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/responsive_screens/garment_selection_tablet.dart';

class ClientGarmentSelectionScreen extends StatelessWidget {
  const ClientGarmentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = CartItemModel.empty(); // Get.arguments;
    
    return ITSiteLayoutTemplate(desktop: GarmentSelectionDesktopScreen(order: order), tablet: GarmentSelectionTabletScreen(order: order), 
    mobile: GarmentSelectionMobileScreen(order: order));
  }
}