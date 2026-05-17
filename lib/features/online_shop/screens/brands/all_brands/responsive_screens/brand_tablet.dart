import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/table/data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class BrandTabletScreen extends StatelessWidget {
  const BrandTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(heading: 'Categories', breadcrumbItems: ['Categories']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Table Body
              //Show Loader

              TRoundedContainer(
                child: Column(

                  // Table Header
                 children: [
                    ITTableHeader(buttonText: 'Create New Category', onPressed: ()  => Get.toNamed(ITRoutes.createCategory)),

                    // Table
               // Table
                   Obx((){
                    if(controller.isLoading.value) return const TLoaderAnimation();
                    return const BrandTable();
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