import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_garment_order_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class ClientGarmentMeasurements extends StatelessWidget {
  const ClientGarmentMeasurements({
    super.key,
    //required this.order,
  });

  //final OrderModel order;
  @override
  Widget build(BuildContext context) {
    final controller = ClientGarmentOrderController.instance;

    return Obx(() {
      final measurement = controller.clientGarmentSelection.value.measurements;

      final subTotal = measurement.fold(
          0.0, (previousvalue, element) => previousvalue + (element.value!));

      return TRoundedContainer(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Measurements',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // Items

            Obx(() {
              return controller.isLoading.value
                  ? TShimmerEffect(width: double.infinity, height: 60)
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: measurement.length,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      itemBuilder: (_, index) {
                        final item = measurement[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  TRoundedImage(
                                    backgroundColor: TColors.primaryBackground,
                                    imageType: item.image != ''
                                        ? ImageType.network
                                        : ImageType.asset,
                                    image: item.image,
                                  ),
                                  SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),
                                  SizedBox(
                                    width: TSizes.xl * 2,
                                    child: Text(
                                      item.value!.toStringAsFixed(1),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  SizedBox(
                                    width: TDeviceUtils.isMobileScreen(context)
                                        ? TSizes.xl * 1.4
                                        : TSizes.xl * 2,
                                    child: Text(
                                      '1',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  SizedBox(
                                    width: TDeviceUtils.isMobileScreen(context)
                                        ? TSizes.xl * 4
                                        : TSizes.xl * 2,
                                    child: Text(
                                      item.value!.toStringAsFixed(1),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
            }),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // Item Totals

            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              backgroundColor: TColors.primaryBackground,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Measurements',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        subTotal.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        order.shippingCost.toStringAsFixed(1),
                       // style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        //order.taxCost.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Divider(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '\Ksh ${order.totalAmount.toStringAsFixed(1)}',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ), */
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
