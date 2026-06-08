import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_detail_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class OrderCustomerInfo extends StatelessWidget {
  const OrderCustomerInfo({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TRoundedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal information
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
        
              const SizedBox(height: TSizes.spaceBtwSections),
        
              Obx(
                (){
                  return Row(
                children: [
                  TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    image: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : TImages.user,
                    imageType: controller.customer.value.profilePicture.isNotEmpty  ? ImageType.network : ImageType.asset,
                  ),
        
                  const SizedBox(width: TSizes.spaceBtwItems),
        
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.customer.value.firstName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
        
                         Text(
                          controller.customer.value.email,
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
              
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.spaceBtwSections),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                        'Contact Info',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                        Text(
                         controller.customer.value.fullName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems / 2),                        
                        Text(
                          controller.customer.value.email,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        
                        const SizedBox(height: TSizes.spaceBtwSections / 2),
                                                
                        Text(
                           controller.customer.value.formattedPhoneNo.isNotEmpty ? controller.customer.value.formattedPhoneNo : '(+254 **** ***)',
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
                        'Shipping address',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
        
        
                      Text(
                        order.shippingAddress != null ? order.shippingAddress!.name : 'Some Address',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
        
                      Text(
                        order.shippingAddress != null ? order.shippingAddress!.toString() : '',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
        
                      
                    ],
                  ),
                ),
              ),
               const SizedBox(height: TSizes.spaceBtwSections / 2),
        
               SizedBox(
                width: double.infinity,
                child: TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Billing address',
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
                const SizedBox(height: TSizes.spaceBtwSections),
        
        
        
            ],
          
        
      
    );
  }
}