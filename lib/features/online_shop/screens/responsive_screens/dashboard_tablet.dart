import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/tablets/data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/widgets/dashboard_card.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/widgets/order_status_pie_chart.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/widgets/weekly_sales.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

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

              /// Cards
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
                  
                ],
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              
               Row(
                children: [
                  
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
              WeeklySalesScreen(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
                        
              /// Orders
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                              SizedBox(
                              width: TSizes.spaceBtwSections,
                            ),
                            const DashboardOrderTable()


                            ],
                          ),
                        ),
              SizedBox(
                width: TSizes.spaceBtwSections,
              ),
              
              /// Pie Chart
              OrderStatusPieChart()
              
            ],
          ),
        ),
      ),
    );
  }
}