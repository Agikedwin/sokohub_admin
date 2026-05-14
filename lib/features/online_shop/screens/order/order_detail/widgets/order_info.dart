import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order, });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Order Infomation', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),     
          
          Row(
            children: [
              Expanded(
                child: Column(
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
                 Text('Items', style:  Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1,),
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
                  TRoundedContainer(
                    radius: TSizes.cardRadiusSm,
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: 0),
                    backgroundColor: THelperFunctions.getOrderStatusColor(order.status!).withValues(alpha: 0.1),
                    child: DropdownButton<OrderStatus>(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      value: order.status!,
                      onChanged: (OrderStatus? newValue){},
                      items: OrderStatus.values.map((OrderStatus status){
                        return DropdownMenuItem<OrderStatus>(
                          value: status,
                          child: Text(
                            status.name.capitalize.toString(),
                            style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status!)),
                          ),

                        );
                      }).toList(),
                    ),
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