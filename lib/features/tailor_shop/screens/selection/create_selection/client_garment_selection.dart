import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/create_selection/responsive_screens/create_garment_selection_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/create_selection/responsive_screens/create_garment_selection_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/create_selection/responsive_screens/create_garment_selection_tablet.dart';

class ClientGarmentSelectionScreen extends StatelessWidget {
  const ClientGarmentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order =  CartItemModel.empty(); // Get.arguments; //;
    final controller = Get.put(OrderController());
    
    return ITSiteLayoutTemplate(desktop: CreateGarmentSelectionDesktopScreen(order: order), tablet: CreateGarmentSelectionTabletScreen(order: order), 
    mobile: CreateGarmentSelectionMobileScreen(order: order));
  }
}