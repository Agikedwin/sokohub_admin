import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_detail_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class CustomerOrderRows extends DataTableSource {
  final controller = CustomerDetailController.instance;

  @override
  DataRow? getRow(int index) {
    // Prevent out-of-range errors
    if (index >= controller.filteredCustomerOrders.length) {
      return null;
    }

    final order = controller.filteredCustomerOrders[index];


    // Safe total calculation
    final totalAmount = (order.items ?? []).fold<double>(
      0,
      (previousValue, element) =>
          previousValue + (element.price ?? 0.0),
    );

    return DataRow2(
      selected: controller.selectedRows.length > index
          ? controller.selectedRows[index]
          : false,

      onTap: () => Get.toNamed(
        ITRoutes.ordersDetail,
        arguments: order,
      ),

      cells: [
        DataCell(
          Text(
            order.id ?? '',
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge
                ?.apply(color: TColors.primary),
          ),
        ),

        DataCell(
          Text(order.formatedOrderDate ?? ''),
        ),

        DataCell(
          Text('${(order.items ?? []).length} items'),
        ),

        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),

            // FIXED: withValues -> withOpacity
            backgroundColor:
                THelperFunctions.getOrderStatusColor(
                  order.status!,
                ).withOpacity(0.1),

            child: Text(
              order.status?.name.capitalize ?? 'Unknown',
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(
                  order.status!,
                ),
              ),
            ),
          ),
        ),

        DataCell(
          Text(totalAmount.toStringAsFixed(2)),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>
      controller.filteredCustomerOrders.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows
          .where((selected) => selected)
          .length;
}