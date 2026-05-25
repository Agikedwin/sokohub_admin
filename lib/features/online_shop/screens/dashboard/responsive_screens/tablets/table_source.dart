import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_detail_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';
class OrderRows extends DataTableSource {

  final controller = OrderController.instance;

  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    

    // Convert String to OrderStatus

    return DataRow2(
      onTap: () => Get.toNamed(ITRoutes.ordersDetail,  arguments: order),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Text(
            order.docId,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
          ),
        ),

        DataCell(Text(order.formatedOrderDate)),

        const DataCell(Text('7 Items')),

        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.xs,
              horizontal: TSizes.md,
            ),
            backgroundColor:
                THelperFunctions.getOrderStatusColor(order.status!)
                    .withValues(alpha: 0.1),

            child: Text(
              order.status!.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status!),
              ),
            ),
          ),
        ),
        DataCell(
          Text(' \Ksh ${order.totalAmount}'),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.instance.orderController.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}