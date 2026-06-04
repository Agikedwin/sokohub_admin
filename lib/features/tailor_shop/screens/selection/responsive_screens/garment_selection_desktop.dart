import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/client_selection.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/garment_accessories_widget.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/garment_measurents_widget.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/garment_order_details.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/garment_selection_widget.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/material_selection_widget.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/save_selection_button_widget.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/widgets/selection_note_widget.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentSelectionDesktopScreen  extends StatelessWidget {
  const GarmentSelectionDesktopScreen ({super.key,  required this.order});
final CartItemModel  order;
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
                heading: 'Client Zone',
                 breadcrumbItems: ['Zone']),
              SizedBox(height: TSizes.spaceBtwSections,),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Order Info
                        GarmentOrderDetails(order: order,),
                         
                       
                       
                       
                      ],
                    ),
                  ),
                  
                ],
              ),
               SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),


              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex:  2,//TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        ClientSelection(),
                        SizedBox(height: TSizes.spaceBtwItems, ),
                        
                        GarmentSelectionWidget(),
                        SizedBox(height: TSizes.spaceBtwItems, ),

                        MaterialSelectionWidget(),
                        SizedBox(height: TSizes.spaceBtwItems, ),

                        SelectionNoteWidget(),

                        SizedBox(height: TSizes.spaceBtwItems, ),
                        SaveSelectionButtonWidget()
                      ],
                    ),
                  ),

                const SizedBox(width: TSizes.spaceBtwItems),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GarmentMeasurentsWidget(),
                      
                      SizedBox(height: TSizes.spaceBtwItems, ),

                      GarmentAccessoriesWidget()
                    ],
                  ),
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