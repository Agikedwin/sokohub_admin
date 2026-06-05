import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/table/data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/table/material_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/all_selections/table/garment_selection_data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentSelectionDesktopScreen extends StatelessWidget {
  const GarmentSelectionDesktopScreen({super.key, });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GarmentSelectionController());
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
                heading: 'Garment Selection',
                 breadcrumbItems: ['Garment Selection']),
              SizedBox(height: TSizes.spaceBtwSections,),
              

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(
                      buttonText: '',
                     onPressed: ()  => Get.toNamed(ITRoutes.createGarmentSelection),
                     searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                     ),

                    // Table
                   Obx((){ 
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const GarmentSelectionTable();
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