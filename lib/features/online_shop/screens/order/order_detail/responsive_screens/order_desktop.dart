import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';

import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_items.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_transactions.dart';
import 'package:sokohub_admin/routes/routes.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';

class OrderDetailDesktopScreen extends StatelessWidget {
  const OrderDetailDesktopScreen({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(
                      returnToPreviousScreen: true,
                      heading: order.docId,
                      breadcrumbItems: [ITRoutes.orders, 'Details']
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

              //  Body

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side Order Information

                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Info
                        OrderInfo( order: order,),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // Items
                        OrderItems(order: order),

                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        // Transactins
                        OrderTransactions( order: order)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),

                  // Right side User Information
                  Expanded(
                      child: Column(
                    children: [
                      // Customer Info
                      OrderCustomerInfo(order: order),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
