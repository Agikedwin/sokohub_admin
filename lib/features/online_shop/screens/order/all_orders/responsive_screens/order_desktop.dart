import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/table/order_table.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class OrderDesktopScreen extends StatelessWidget {
  const OrderDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading( heading: 'Orders', breadcrumbItems: ['Orders'],),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader( buttonText: '', showLeftWidget: false, 
                    searchController: controller.searchTextController,
                    searchOnChanged: (query) => controller.searchQuery(query),
                    
                    ),

                      SizedBox(height: TSizes.spaceBtwItems,),

                    // Table
                   
                   Obx((){
                    // Loader
                     if(controller.isLoading.value)  return TLoaderAnimation();
                     return  OrderTable();
                   } ),
                 ],


             

                ),
                
              )

              

            ],
          ),
        ),
      ),
    );
  }
}