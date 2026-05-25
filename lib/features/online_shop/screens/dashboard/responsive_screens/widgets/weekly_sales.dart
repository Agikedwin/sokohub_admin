import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/t_circular_icon.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class TWeeklySalesScreen extends StatelessWidget {
  const TWeeklySalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withValues(alpha: 0.1),
                color: Colors.brown,
                size: TSizes.md,
              ),
              Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //
          //Graph

          Obx(
            () => controller.weeklySales.isNotEmpty 
            ? SizedBox(
              height: 400,
              child: BarChart(BarChartData(
                  titlesData: buildFlTitlesdata(controller.weeklySales),
                  borderData: FlBorderData(
                      show: true,
                      border:
                          Border(top: BorderSide.none, right: BorderSide.none)),
                  gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false,
                      horizontalInterval: 200),
                  barGroups: controller.weeklySales
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(x: entry.key, barRods: [
                            BarChartRodData(
                              width: 30,
                              toY: entry.value,
                              color: TColors.primary,
                              borderRadius: BorderRadius.circular(TSizes.sm),
                            )
                          ]))
                      .toList(),
                  groupsSpace: TSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => TColors.secondary),
                    touchCallback: TDeviceUtils.isDesktopScreen(context)
                        ? (barTouchEvent, barTouchResponse) {}
                        : null,
                  ))),
            ): SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [TLoaderAnimation()],),),
          )
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesdata(List<double> weeklySales) {
    // Calculate Step height for the left pricing
    //Returns max order
    double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b);
    double stepHeight = (maxOrder / 10).ceilToDouble();
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            final index = value.toInt() % days.length;
            final day = days[index];

            return SideTitleWidget(
              meta: meta,
              space: 0,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, interval: stepHeight <= 0 ? 500 : stepHeight, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
