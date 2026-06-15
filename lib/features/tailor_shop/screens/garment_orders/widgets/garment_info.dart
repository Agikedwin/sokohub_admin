import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_garment_order_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';


class GarmentInfo extends StatelessWidget {
  const GarmentInfo({super.key });


  @override
  Widget build(BuildContext context) {
    final controller = ClientGarmentOrderController.instance;   
    
    return  TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Obx(() =>  controller.isLoading.value ? TShimmerEffect(width: double.infinity, height: 10) : Text('Date: ${controller.clientGarmentSelection.value.formattedDate}', style:  Theme.of(context).textTheme.headlineMedium,)),
          const SizedBox(height: TSizes.spaceBtwSections ,),     
          
          Obx(
            () {
              final items = controller.clientGarmentSelection.value;

            return controller.isLoading.value ? TShimmerEffect(width: double.infinity, height: 60)
            : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('item'),
                   Text('${items.clientOrder.title} ', style:  Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1,),
                    if(items.clientOrder.selectedVariation != null)
                              Text(items.clientOrder.selectedVariation!.entries.map((e) => ('${e.key} : ${e.value}')).toString()),
            
                ],
              ),
             ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  Text('Garment'),
                   Text( items.garment.name ,style:  Theme.of(context).textTheme.titleMedium,),
                  
                      ],
                    ),
                ),
            
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Material'),
                    Text(items.material.name,  style:  Theme.of(context).textTheme.bodyLarge,),
            
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