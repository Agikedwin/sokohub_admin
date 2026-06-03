import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order, });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    controller.orderStatus.value = order.status!;
    return  TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Order Information', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),     
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                Text('Date'),
                 Text( order.formatedOrderDate,style:  Theme.of(context).textTheme.titleMedium,),
                
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
                 Text('${order.items!.length} ', style:  Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1,),
                  //Text('${order.items!.length} items',  style:  Theme.of(context).textTheme.bodyLarge,),

              ],
            ),
           ),
            Expanded(
              flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Status'),
                  Obx(
                    (){
                      if (controller.statusLoader.value) return const TShimmerEffect(width: double.infinity, height: 55);
                      return TRoundedContainer(
                      radius: TSizes.cardRadiusSm,
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: 0),
                      backgroundColor: THelperFunctions.getOrderStatusColor(controller.orderStatus.value).withValues(alpha: 0.1),
                      child: DropdownButton<OrderStatus>(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        value: controller.orderStatus.value,
                        onChanged: (OrderStatus? newValue){
                          if(newValue != null){
                            controller.updateOrderStatus(order, newValue);
                          }
                        },
                        items: OrderStatus.values.map((OrderStatus status){
                          return DropdownMenuItem<OrderStatus>(
                            value: status,
                            child: Text(
                              status.name.capitalize.toString(),
                              style: TextStyle(color: THelperFunctions.getOrderStatusColor(controller.orderStatus.value)),
                            ),
                    
                          );
                        }).toList(),
                      ),
                    );
                    }
                  )

              ],
            ),
           ),

            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Total'),
                  Text('${order.totalAmount} items',  style:  Theme.of(context).textTheme.bodyLarge,),

              ],
            ),
           ),


            ],
          ),

            ],
          ),


      );
    
  }
}