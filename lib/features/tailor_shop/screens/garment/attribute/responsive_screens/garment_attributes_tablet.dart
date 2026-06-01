import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/table/garment_data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentAttributesTabletScreen  extends StatelessWidget {
  const GarmentAttributesTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(heading: 'Garment', breadcrumbItems: ['Garment']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(buttonText: 'Create New Category', onPressed: ()  => Get.toNamed(ITRoutes.createGarment),
                    searchController: controller.searchTextController,
                    searchOnChanged: (query) => controller.searchQuery(query),
                    ),

                    // Table
               GarmentTable(),
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