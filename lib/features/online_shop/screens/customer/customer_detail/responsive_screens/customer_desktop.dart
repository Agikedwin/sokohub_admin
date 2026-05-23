import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  const CustomerDetailDesktopScreen({super.key, required this.customer, });

 final UserModel customer;

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
                breadcrumbItems: [ ITRoutes.customers, 'Details']),
              SizedBox(height: TSizes.spaceBtwSections,),

              //  Body

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side customer Information

                  Expanded(
                    child: Column(
                      children: [
                        // <Customer Info
                      // CustomerInfo(customer: customer),
                        CustomerInfo(customer: customer,),
                         SizedBox(height: TSizes.spaceBtwItems,),

                         // Shipping address
                          ShippingAddress(customer: customer,)                         
                      ],
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems,),

                  // Right side customer orders
                  const Expanded(flex: 2, child: CustomerOrders())
                ],
              )
            

              ],
          ),
        ),
      ),
    );
  }
}