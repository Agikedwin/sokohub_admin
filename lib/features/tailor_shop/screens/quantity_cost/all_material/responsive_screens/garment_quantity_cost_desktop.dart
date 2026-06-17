import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_material/table/material_quantity_cost_data_table.dart';

import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MaterialQuantityCostDesktopScreen extends StatelessWidget {
  const MaterialQuantityCostDesktopScreen({super.key, });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GarmentSelectionController());
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true, 
                heading: 'Material',
                 breadcrumbItems: ['Material Quantity']),
              SizedBox(height: TSizes.spaceBtwSections,),
              

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // Table Header
                 children: [
                    /* ITTableHeader(
                      buttonText: '',
                     onPressed: ()  => Get.toNamed(ITRoutes.createGarmentSelection),
                     searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                     ),
                     
                    */
                     Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('', style:  Theme.of(context).textTheme.headlineMedium,),
                  Obx(
                    () => controller.totalGarmentAmountToPurchase.value == 0.0 ? TShimmerEffect(width: 30, height: 20) : Text.rich(
                      TextSpan(
                        children: [ 
                          const TextSpan(text: 'Total Material Cost: '),
                          TextSpan(text: '\Ksh ${controller.totalGarmentAmountToPurchase.toString()}', style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors.primary)),
                          //TextSpan( text: ' on ${controller.allCustomerOrders.length} Orders', style:  Theme.of(context).textTheme.bodyLarge,),
                        ]
                      )
                    ),
                  ),
                    ],
                  ),
                    // Table
                   Obx((){ 
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const MaterialQuantityCostTable();
                    }),
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