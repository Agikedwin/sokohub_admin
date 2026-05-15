import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';

import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/responsive_screens/order_desktop.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
   //final order = Get.arguments;
   final order = OrderModel(id: 'id', status: OrderStatus.shipped, userId: 'userId', 
    totalAmount: 9000, orderDate: DateTime.now(),
    items: [CartItemModel(productId: '12', title: 'Test', price: 200, totalAmount: 800, quantity: 5, variationId: 'single',
     brandName: 'Nike')]);
   
    return  ITSiteLayoutTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}
