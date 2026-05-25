import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/tablets/data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/order_status_pie_chart.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/responsive_screens/widgets/weekly_sales.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final controller  = Get.put(DashboardController());

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
                height: TSizes.spaceBtwSections / 2,
              ),

              // Row
              Obx(
                () => TDashboardCard(
                  headingIcon: Iconsax.note,
                  headingIconBgColor: Colors.blue,
                  headingIconColor: Colors.blue.withValues(alpha: 0.1),
                  stats: 25,
                  title: 'Sales total',
                  subTitle: '\ksh${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  headingIcon: Iconsax.note,
                  headingIconBgColor: Colors.blue,
                  headingIconColor: Colors.blue.withValues(alpha: 0.1),
                  stats: 15,
                  title: 'Average Order Value',
                  subTitle: '\ksh${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(1)}',
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  headingIcon: Iconsax.note,
                  headingIconBgColor: Colors.blue,
                  headingIconColor: Colors.blue.withValues(alpha: 0.1),
                  stats: 45,
                  title: 'Total Orders',
                  subTitle: 'Ksh ${controller.orderController.allItems.length}',
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => TDashboardCard(
                  headingIcon: Iconsax.note,
                  headingIconBgColor: Colors.blue,
                  headingIconColor: Colors.blue.withValues(alpha: 0.1),
                  stats: 3,
                  title: 'Visitirs',
                  subTitle: controller.orderController.allItems.length.toString(),
                ),
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// GRAPHS
              TWeeklySalesScreen(),
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