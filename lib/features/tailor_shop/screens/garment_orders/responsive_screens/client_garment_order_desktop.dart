import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/garment__info.dart';
import 'package:sokohub_admin/routes/routes.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';

class ClientGarmentOrderDesktop extends StatelessWidget {
  const ClientGarmentOrderDesktop({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(
                      returnToPreviousScreen: true,
                      heading: '',
                      breadcrumbItems: [ITRoutes.orders, 'Client Order']
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

              //  Body

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side Order Information

                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Info
                        OrderInfo(),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // Items
                       // OrderItems(clientOrder: clientOrder),

                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        // Transactins
                       // OrderTransactions(clientOrder: clientOrder)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),

                  // Right side User Information
                  Expanded(
                      child: Column(
                    children: [
                      // Customer Info
                      //OrderCustomerInfo(clientOrder: clientOrder),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
