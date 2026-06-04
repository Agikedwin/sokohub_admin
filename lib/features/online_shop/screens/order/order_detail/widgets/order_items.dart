import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/t_circular_icon.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/employee_order_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order,});

  final OrderModel order;


  @override
  Widget build(BuildContext context) {
    //final userController = CustomerController.instance;
    //final employeeController = Get.put(EmployeeOrderController());  
        
    final subTotal = order.items!.fold(0.0, (previousvalue, element) => previousvalue + (element.price * element.quantity));
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
            itemCount: order.items!.length,
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
                              Row(
                                
                                children: [
                                  Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,

                              ),
                             // TCircularIcon(icon: Icons.forward, backgroundColor: TColors.primary, onPressed: () => Get.toNamed(ITRoutes.garmentSelection, arguments: item),)
                             //IconButton.outlined(onPressed: () => Get.toNamed(ITRoutes.garmentSelection, arguments: item), icon: Icon(Iconsax.arrow_right_3)),
                             TextButton.icon(onPressed: () => Get.toNamed(ITRoutes.garmentSelection, arguments: item), label: Icon(Iconsax.edit)),
                                ],
                              ),
                              
                              if(item.selectedVariation != null)
                              Text(item.selectedVariation!.entries.map((e) => ('${e.key} : ${e.value}')).toString()),
                             
                            ],
                          ),
                        ),
                        SizedBox(height: TSizes.spaceBtwItems,),

                        SizedBox(
                          width: TSizes.xl * 2,
                          child: Text(item.price.toStringAsFixed(1), style: Theme.of(context).textTheme.bodyLarge,),
                        ),

                         SizedBox(
                          width: TDeviceUtils.isMobileScreen(context) ?   TSizes.xl * 1.4 : TSizes.xl * 2,
                          child: Text(item.quantity.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                        ),
                         SizedBox(
                          width: TDeviceUtils.isMobileScreen(context) ?   TSizes.xl * 4 : TSizes.xl * 2,
                          child: Text(item.totalAmount, style: Theme.of(context).textTheme.bodyLarge,),
                        )



                      ],
                    ),
                  )
                ],
                
              );
            },           
              
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
                      Text(subTotal.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount', style: Theme.of(context).textTheme.titleLarge,),
                      Text('0.00', style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),

                   SizedBox(height: TSizes.spaceBtwItems,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: Theme.of(context).textTheme.titleLarge,),
                      Text(order.shippingCost.toStringAsFixed(1), 
                      style: Theme.of(context).textTheme.titleLarge,)
                    ],
                  ),
                   SizedBox(height: TSizes.spaceBtwItems,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax', style: Theme.of(context).textTheme.titleLarge,),
                      Text(order.taxCost.toStringAsFixed(1), 
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
                      Text('\Ksh ${order.totalAmount.toStringAsFixed(1)}', 
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