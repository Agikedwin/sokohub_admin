import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/table/accessory_data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class AccessoryDesktopScreen extends StatelessWidget {
  const AccessoryDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccessoryController());
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
                heading: 'Accessory',
                 breadcrumbItems: ['Accessory']),
              SizedBox(height: TSizes.spaceBtwSections,),
              

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(buttonText: 'Create New Accessory',
                     onPressed: ()  => Get.toNamed(ITRoutes.createAccessory),
                     searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                     ),

                    // Table
                   Obx((){ 
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const AccessoryTable();
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