import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/circular_container.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/t_circular_icon.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             // Graph
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.status,
                backgroundColor: Colors.amber.withValues(alpha: 0.1),
                color: Colors.amber,
                size: TSizes.sm,
              ),
              const SizedBox(width: TSizes.spaceBtwItems,),
              Text('Order Status', style: Theme.of(context).textTheme.headlineSmall),
              
            ],
          ),      
           
           
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => controller.orderStatusData.isNotEmpty
                  ? SizedBox(
                    height: 400,
                    child: PieChart(
                      PieChartData(
                        sections: controller.orderStatusData.entries
                        .map((entry){
                          final status = entry.key;
                          final count = entry.value;
                          return PieChartSectionData(
                            radius: 100,                  
                            title: count.toString(),
                            value: count.toDouble(),
                            color: THelperFunctions.getOrderStatusColor(status),
                            titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                          );
                          }
                        ).toList(),
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            
                          },
                          enabled: true
                        )
                      )
                    ),
                  ) : SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [TLoaderAnimation()],),),
                ),
              ],
            ),

            // show status and color meta

            SizedBox(
              width: double.infinity,
              child: Obx(
                () => DataTable(
                  columns: [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Orders')),
                    DataColumn(label: Text('Total'))
                  ] ,            
                rows:  controller.orderStatusData.entries.map((entry){
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
                           
                return DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        TCircularContainer(width: 20, height: 20, backgroundColor: THelperFunctions.getOrderStatusColor(status)),
                        Expanded(child: Text(controller.getOrderStatusName(status)))
                      ],
                    )
                  ),
                  DataCell(Text(count.toString())),
                  DataCell(Text(totalamount.toString()))
                ]);
                           }).toList() 
                           ),
              ),
            )
      
      
      
        ],
      
      ),
    );
  }
}