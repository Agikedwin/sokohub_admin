import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';

import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderDetailsRows extends DataTableSource{
  @override
  DataRow? getRow(int index) {

    final order = OrderModel(id: 'id', status: OrderStatus.shipped, userId: 'userId', totalAmount: 9000, orderDate: DateTime.now());
   const totalAmount = '59807';
    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(ITRoutes.ordersDetail, arguments: order),
      cells: [
        DataCell(
          Text(
           order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
            )
        ),
         DataCell(Text(order.formatedOrderDate,)),
        const DataCell(Text('${5} items')),
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
        const DataCell(Text('\$$totalAmount')),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
  
}