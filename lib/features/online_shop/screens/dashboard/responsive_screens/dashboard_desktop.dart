import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/texts/section_heading.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product_images_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/dashboard.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/tablets/data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/order_status_pie_chart.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/weekly_sales.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class DashboardDestopScreen extends StatelessWidget {
  const DashboardDestopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(ProductImagesController());
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
              ElevatedButton(onPressed: () => controller.selectThumnailImage(), child: Text('Select Single Image')),
              const SizedBox(height: TSizes.spaceBtwSections,),
               ElevatedButton(onPressed: () => controller.selectMultipeProductImages(), child: Text('Select Multiple  Images')),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graphs

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
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),

                  /// Pie Chart
                  Expanded(child: OrderStatusPieChart()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
