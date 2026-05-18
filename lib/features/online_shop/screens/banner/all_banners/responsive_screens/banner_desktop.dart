import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/banner_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/table/data_table.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class BannerDesktopScreen extends StatelessWidget {
  const BannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Banners', breadcrumbItems: ['Banners']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Table Body
              //Show Loader

              Obx(
                (){
                   if(controller.isLoading.value) return const TLoaderAnimation();
                   return TRoundedContainer(
                  child: Column(
                
                    // Table Header
                   children: [
                      ITTableHeader(buttonText: 'Create New Banner',
                       onPressed: ()  => Get.toNamed(ITRoutes.createBanner), 
                       showLeftWidget: true,
                       searchOnChanged: (query) => controller.searchQuery(query),
                       searchController: controller.searchTextController,
                
                       ),
                
                      // Table
                             
                     
                       BannerTable()
                     
                   ],
                
                
                             
                
                  ),
                  
                );
                } 
              )

              

            ],
          ),
        ),
      ),
    );
  }
}