import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/responsive_screens/client_garment_order_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/responsive_screens/client_garment_order_mobile.dart';


class ClientGarmentOrderScreen extends StatelessWidget {
  const ClientGarmentOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
   
     return  ITSiteLayoutTemplate(
      desktop: ClientGarmentOrderDesktop(),
      mobile: ClientGarmentOrderMobile(),
    ); 
  }
}
