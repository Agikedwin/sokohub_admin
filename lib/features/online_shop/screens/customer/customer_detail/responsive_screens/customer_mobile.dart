import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/table/product_table.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, });
  
    //final UserModel customer;

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

              //customer info

             // CustomerInfo(customer: customer),
               CustomerInfo(),
               SizedBox(height: TSizes.spaceBtwSections,),
                        
               // Shipping address
            const ShippingAddress(),
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