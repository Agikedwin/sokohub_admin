import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/all_tasks_tracking/table/tasks_tracking_data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class TasksTrackingDesktopScreen extends StatelessWidget {
  const TasksTrackingDesktopScreen({super.key, required this.tracking});

  final ClientSelectionAttributesModel tracking;

  @override
  Widget build(BuildContext context) {
    final controller = GarmentSelectionController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Brands', breadcrumbItems: ['Brands']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(buttonText: 'Create New Brand', 
                    onPressed: ()  => Get.toNamed(ITRoutes.createBrand),
                    searchOnChanged: (query) => controller.searchQuery(query),
                    ),

                    // Table
                   Obx((){
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const TasksTrackingDataTable();
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