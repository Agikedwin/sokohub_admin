import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/table/garment_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/all_measurements/table/measurements_data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MeasurementDesktopScreen extends StatelessWidget {
  const MeasurementDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeasurementController());
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
                heading: 'Measurement',
                 breadcrumbItems: ['Measurement']),
              SizedBox(height: TSizes.spaceBtwSections,),
              

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(buttonText: 'Create New Measurement',
                     onPressed: ()  => Get.toNamed(ITRoutes.createMeasurement),
                     searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                     ),

                    // Table
                   Obx((){ 
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const MeasurementTable();
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