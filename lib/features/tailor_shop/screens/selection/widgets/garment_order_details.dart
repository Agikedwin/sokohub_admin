import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';

import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class GarmentOrderDetails extends StatelessWidget {
  const GarmentOrderDetails({super.key,  required this.order});

final CartItemModel order;
  @override
  Widget build(BuildContext context) {
    
    final controller = OrderController.instance; 
    final selectedItem = controller.selectedOrder;
    //set selected client order
    controller.selectedClientCart.value =order;
    

    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Garment ', style:  Theme.of(context).textTheme.headlineMedium,),
          // meta data

          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                     TRoundedImage(
                      imageType: order.image!.isNotEmpty ? ImageType.network : ImageType.asset, 
                      image:  order.image!.isNotEmpty ?  order.image : null,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Garment Name', style: Theme.of(context).textTheme.labelMedium,),
                      Text(order.title, style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    )
                  ],
                ),
              ),

               Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date ', style: Theme.of(context).textTheme.labelMedium,),
                      Text(selectedItem.value.formatedOrderDate, style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reference', style: Theme.of(context).textTheme.labelMedium,),
                      Text(selectedItem.value.orderId ?? '',  style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    ),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ordered By', style: Theme.of(context).textTheme.labelMedium,),
                      Text('Melisa' , style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    )
                    
            ],
          )


            ],
          )

        
      );
    
  }
}