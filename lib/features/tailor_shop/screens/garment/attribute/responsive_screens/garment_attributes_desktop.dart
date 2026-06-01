import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/table/garment_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/accessory_details.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/garment_info.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/measuremnts_details.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentAttributesDesktopScreen extends StatelessWidget {
  const GarmentAttributesDesktopScreen ({super.key, required this.garment});
final GarmentModel garment;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                returnToPreviousScreen: true, 
                heading: 'Garment',
                 breadcrumbItems: ['Garment']),
              SizedBox(height: TSizes.spaceBtwSections,),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Order Info
                        GarmentInfo(garment: garment),
                       
                       
                      ],
                    ),
                  ),
                  
                ],
              ),
               SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),


             Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MeasuremntsDetails(),
                      ],
                    ),
                  ),

                const SizedBox(width: TSizes.spaceBtwItems),

                Expanded(
                  child: AccessoryDetails(),
                ),
              ],
            ),
           
            ],
          ),
        ),
      ),
    );
  }
}