import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/texts/section_heading.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/widgets/dashboard_card.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class DashboardDestopScreen extends StatelessWidget {
  const DashboardDestopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Row
              Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Sales total',
                      subTitle: '\$36500',
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 15,
                      title: 'Average Order Value',
                      subTitle: '\$36500',
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 45,
                      title: 'Total Orders',
                      subTitle: '37',
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 3,
                      title: 'Visitirs',
                      subTitle: '38,000',
                    ),
                  )
                ],
              ),

               const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

              /// GRAPHS
              const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graphs
                        
                        TRoundedContainer(),
                         SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                        /// Orders
                         TRoundedContainer(),

                        
                      ],
                    ),
                  ),
                   SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),


                  /// Pie Chart
                   Expanded(child: TRoundedContainer()),

                ],

              )
              
            ],
          ),
        ),
      ),
    );
  }
}
