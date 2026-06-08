import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';


class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key });


  @override
  Widget build(BuildContext context) {
    final controller = GarmentSelectionController.instance;
    
    return  TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Order Information', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),     
          
          Obx(
            () {

            return controller.isLoading.value ? TShimmerEffect(width: double.infinity, height: 60)
            : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  Text('Date'),
                   Text( controller.clientGarmentSelection.value.formattedDate,style:  Theme.of(context).textTheme.titleMedium,),
                  
                      ],
                    ),
                ),
                /* TRoundedImage(
                  padding: 0,
                  backgroundColor: TColors.primaryBackground,
                  image: TImages.user,
                  imageType: ImageType.asset,
                ), */
            
                // const SizedBox(height: TSizes.spaceBtwItems ,),
            
             Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('item(s)'),
                   Text('${controller.clientGarmentSelection.value.clientOrder.title} ', style:  Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1,),
                    //Text('${order.items!.length} items',  style:  Theme.of(context).textTheme.bodyLarge,),
            
                ],
              ),
             ),
              
            
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Total'),
                    Text('${controller.clientGarmentSelection.value.orderId} items',  style:  Theme.of(context).textTheme.bodyLarge,),
            
                ],
              ),
             ),
            
            
              ],
            );
            }
          ),

            ],
          ),


      );
    
  }
}