import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_desktop.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/responsive_screens/client_garment_order_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/responsive_screens/client_garment_order_mobile.dart';


class ClientGarmentOrderScreen extends StatelessWidget {
  const ClientGarmentOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GarmentSelectionController.instance;
   final clientGarmentId = Get.parameters['clientGarmentId'];
   controller.getClientDelectionOrdersById(clientGarmentId!);
   
     return  ITSiteLayoutTemplate(
      desktop: ClientGarmentOrderDesktop(),
      mobile: ClientGarmentOrderMobile(),
    ); 
  }
}
