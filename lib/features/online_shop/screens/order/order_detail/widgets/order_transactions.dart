import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class OrderTransactions extends StatelessWidget {
  const OrderTransactions({super.key, required this.order,});

 final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Transactions', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),
          // meta data

          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    const TRoundedImage(imageType: ImageType.asset, image: TImages.paypal,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment via ${order.paymentMethod.capitalize}', style: Theme.of(context).textTheme.titleLarge,),
                      Text('${order.paymentMethod.capitalize} fee \ksh 30', style: Theme.of(context).textTheme.labelMedium,),

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
                      Text('May 14, 2026', style: Theme.of(context).textTheme.bodyLarge,),

                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total', style: Theme.of(context).textTheme.labelMedium,),
                      Text('\ksh${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge,),

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