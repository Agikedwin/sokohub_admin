import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_detail_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_garment_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ClientInfo extends StatelessWidget {
  const ClientInfo({
    super.key,
    //required this.order,
  });

  //final OrderModel order;

  @override
  Widget build(BuildContext context) {
     final controller = ClientGarmentOrderController.instance;
     final client = controller.clientGarmentSelection.value.client;
     
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal information
              Text(
                'Client',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
        
              const SizedBox(height: TSizes.spaceBtwSections),
        
              Obx(
                (){

                  return controller.isLoading.value ? TShimmerEffect(width: double.infinity, height: 60)
                   : Row(
                children: [
                  TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    image: client!.profilePicture.isNotEmpty ? client.profilePicture: TImages.user,
                    imageType: client.profilePicture.isNotEmpty  ? ImageType.network : ImageType.asset,
                  ),
        
                  const SizedBox(width: TSizes.spaceBtwItems),
        
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.firstName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
        
                         Text(
                          client.email,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              );
                }
              )
            ]
              ),
        ),
        
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              // Contact Info  
              
              /* Obx(
                () =>  controller.isLoading.value ? TShimmerEffect(width: double.infinity, height: 60) 
                : SizedBox(
                  width: double.infinity,
                  child: TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.spaceBtwSections),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        'Tasks',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                        Text(
                         client!.fullName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems / 2),                        
                        Text(
                          client.email,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        
                        const SizedBox(height: TSizes.spaceBtwSections / 2),
                                                
                        Text(
                           client.formattedPhoneNo.isNotEmpty ? client.formattedPhoneNo : '(+254 **** ***)',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               const SizedBox(height: TSizes.spaceBtwSections / 2),
        
              // contact info
              
        
               SizedBox(
                width: double.infinity,
                child: TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fundis Assigned',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
        
        
                      Text(
                        'Agik Edwin LTD',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
        
                      Text(
                        'Mbita street',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
        
                      
                    ],
                  ),
                ),
              ),
                const SizedBox(height: TSizes.spaceBtwSections), */
        
        
        
            ],
          
        
      
    );
  }
}