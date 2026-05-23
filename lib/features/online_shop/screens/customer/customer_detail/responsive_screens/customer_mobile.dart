import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_detail_controller.dart';

import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';

import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer, });
  
    final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
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
                heading: customer.fullName, 
                breadcrumbItems: [ ITRoutes.customers, 'Details']),
              SizedBox(height: TSizes.spaceBtwSections,),

              //  Body

              //customer info

              CustomerInfo(customer: customer),
              // CustomerInfo(),
               SizedBox(height: TSizes.spaceBtwSections,),
                        
               // Shipping address
             ShippingAddress(customer: customer,),
              SizedBox(height: TSizes.spaceBtwSections,),
              
              // Right side customer orders
             CustomerOrders()
            

              ],
          ),
        ),
      ),
    );
  }
}