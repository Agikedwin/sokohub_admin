import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_selection_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/selection/edite_selection/responsive_screens/edit_garment_selection_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/edite_selection/responsive_screens/edit_garment_selection_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/edite_selection/responsive_screens/edit_garment_selection_tablet.dart';

class EditClientGarmentSelectionScreen extends StatelessWidget {
  const EditClientGarmentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientSelectionAttributesModel selection =   Get.arguments; 
    final  controller = Get.put(OrderController());
    
    // set the selected client selction
    final selectionController =  Get.put(ClientSelectionOrderController());
    selectionController.selectedClientSelection.value = selection;
    selectionController.init(selection);
    
    
    return ITSiteLayoutTemplate(desktop: EditGarmentSelectionDesktopScreen(selection: selection), tablet: EditGarmentSelectionTabletScreen(selection: selection), 
    mobile: EditGarmentSelectionMobileScreen(selection: selection));
  }
}