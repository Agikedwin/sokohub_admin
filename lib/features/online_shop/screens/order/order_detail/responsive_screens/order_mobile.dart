import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_items.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/widgets/order_transactions.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/table/product_table.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class OrderDetailMobileScreen extends StatelessWidget {
  const OrderDetailMobileScreen({super.key, required this.order, });
  
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
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true, 
                heading: 'Agik Edwin', 
                breadcrumbItems: [ ITRoutes.orders, 'Details']),
              SizedBox(height: TSizes.spaceBtwSections,),

              //  Body

              //customer info

              OrderInfo( order: order,),
               SizedBox(height: TSizes.spaceBtwSections,),
               OrderItems(order: order),
 
              SizedBox(height: TSizes.spaceBtwSections,),
                OrderTransactions( order: order),

               SizedBox(height: TSizes.spaceBtwSections,),
                 OrderCustomerInfo(order: order),
              
              // Right side customer orders
             // customerOrders()
            

              ],
          ),
        ),
      ),
    );
  }
}