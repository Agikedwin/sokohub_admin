import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/client_garment_accessories.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/client_garment_measurements.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/client_garment_tast.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/client_info.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/employee_garment_assignment.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/garment_info.dart';
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
                        GarmentInfo(),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // Items
                        ClientGarmentMeasurements(),

                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        ClientGarmentAccessories(),
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
                      ClientInfo(),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      EmployeeGarmentAssignment(),

                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      // Garment Tasks
                      ClientGarmentTast(),
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
