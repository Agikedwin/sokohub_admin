import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
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
        
              Row(
                children: [
                  TRoundedImage(
                    padding: 0,
                    backgroundColor: TColors.primaryBackground,
                    image: TImages.user,
                    imageType: ImageType.asset,
                  ),
        
                  const SizedBox(width: TSizes.spaceBtwItems),
        
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agik Edwin',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
        
                        const Text(
                          'Agik Edwin',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]
              ),
        ),
        
              const SizedBox(height: TSizes.spaceBtwSections / 2),

              // Contact Info
        
              
              SizedBox(
                width: double.infinity,
                child: TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Person',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
        
        
                      Text(
                        'Agik Edwin',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
        
                      Text(
                        'agikedwin@gmail.com',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
        
                      const SizedBox(height: TSizes.spaceBtwSections / 2),
        
                      Text(
                        '07478976766',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
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