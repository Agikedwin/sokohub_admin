import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/dashboard_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/dashboard/dashboard.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class OrderRows extends DataTableSource{
  @override
  DataRow? getRow(int index) {

    final order = DashboardController.orders[index];
   const totalAmount = '59807';
    return DataRow2(
      selected: false,
     // onTap: () => Get.toNamed(ITRoutes.ordersDetail, arguments: order),
     onSelectChanged: (value) {
       
     },
      cells: [
        DataCell(
          Text(
           order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
            )
        ),
        DataCell(Text('${order.items?.length ?? 0} items')),
         DataCell(Text(order.formatedOrderDate,)),
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
              print('clicked details :::::');
            Get.toNamed(ITRoutes.ordersDetail, arguments: order);

            } ,
            onDeletePressed: () {
              
            },
          )
        )
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
  
}