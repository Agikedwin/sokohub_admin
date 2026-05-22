import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderRows extends DataTableSource{
  final controller = Get.put(OrderController());
  @override
  DataRow? getRow(int index) {

    final order = controller.filteredItems[index];

    final order2 = DashboardController.orders[index];
   const totalAmount = '59807';
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ITRoutes.ordersDetail, arguments: order, parameters: {'orderId': order.docId}),
     onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Text(
           order.docId,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
            )
        ),
         DataCell(Text(order.formatedOrderDate, ) ),
        DataCell(Text('${order.items?.length ?? 0} items')),
        
       // const DataCell(Text('${5} items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(vertical: TSizes.sm, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status!).withValues(alpha: 0.1),
            child: Text(
              order.status!.name.capitalize.toString(),
              style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status!)),

            ),
          )
        ),
       DataCell(Text('\$$totalAmount')),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: (){ 
            Get.toNamed(ITRoutes.ordersDetail, arguments: order, parameters: {'orderId': order.docId});

            } ,
            onDeletePressed: () => controller.deleteOnConfirm(order)
          )
        )
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
  
}