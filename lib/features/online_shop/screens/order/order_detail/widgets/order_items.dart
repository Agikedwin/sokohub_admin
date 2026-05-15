import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/table/customer_order_table.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/api_constants.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';
import 'package:sokohub_admin/utils/helpers/pricing_calculator.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order,});

  final OrderModel order;


  @override
  Widget build(BuildContext context) {
    final order = OrderModel(id: 'id', status: OrderStatus.shipped, userId: 'userId', 
    totalAmount: 9000, orderDate: DateTime.now(),
    items: [CartItemModel(productId: '12', title: 'Test', price: 200, totalAmount: 800, quantity: 5, variationId: 'single',
     brandName: 'Nike')]);
    
    final subTotal =  0.0;// order.items!.fold(0.0, (previousvalue, element) => previousvalue + (element.price * element.quantity));
    return   TRoundedContainer(

      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // Items


          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_,__) => const SizedBox(height: TSizes.spaceBtwItems,),
             itemBuilder: (_, index) {
              final item = order.items![index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          backgroundColor: TColors.primaryBackground,
                          imageType: item.image != null ? ImageType.network: ImageType.asset,
                          image: item.image ?? TImages.defaultImage,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems,),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,

                              ),
                              if(item.selectedVariation != null)
                              Text(item.selectedVariation!.entries.map((e) => ('${e.key} : ${e.value}')).toString()),
                            ],
                          ),
                        ),
                        SizedBox(height: TSizes.spaceBtwItems,),

                        SizedBox(
                          width: TSizes.xl * 2,
                          child: Text('\$${item.price.toStringAsFixed(1)}', style: Theme.of(context).textTheme.bodyLarge,),
                        ),

                         SizedBox(
                          width: TDeviceUtils.isMobileScreen(context) ?   TSizes.xl * 1.4 : TSizes.xl * 2,
                          child: Text('\$${item.quantity.toString()}', style: Theme.of(context).textTheme.bodyLarge,),
                        ),
                         SizedBox(
                          width: TDeviceUtils.isMobileScreen(context) ?   TSizes.xl * 4 : TSizes.xl * 2,
                          child: Text('\$${item.totalAmount}', style: Theme.of(context).textTheme.bodyLarge,),
                        )



                      ],
                    ),
                  )
                ],
                
              );
            },           
              itemCount: order.items!.length
              ),
               SizedBox(height: TSizes.spaceBtwItems,),

            // Item Totals

            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              backgroundColor: TColors.primaryBackground,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubTotal', style: Theme.of(context).textTheme.titleLarge,),
                      Text('\$$subTotal', style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount', style: Theme.of(context).textTheme.titleLarge,),
                      Text('\$0.00', style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: Theme.of(context).textTheme.titleLarge,),
                      Text('\$${TPricingCalculator.calculateShippingCost(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax', style: Theme.of(context).textTheme.titleLarge,),
                      Text('\$${TPricingCalculator.calculateTax(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                   Divider(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: Theme.of(context).textTheme.titleLarge,),
                      Text('\$${TPricingCalculator.calculateTotalPrice(subTotal, '')}', 
                      style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),


                ],
              ),
            )
        ],
        
      ),
    );
    
  }
}