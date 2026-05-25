import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/table/order_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/table/order_detail_table_source.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';



class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(
      (){
        //Text to update UI, do nothing
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());
        return  TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 500,
        dataRowHeight: TSizes.xl * 1.2,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns:  [
          DataColumn2(
            label: Text('Order ID', ), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending),
            ),
          DataColumn2(label: Text('Date'),
         
          ),
          DataColumn2(label: Text('Items'),
          ),
           DataColumn2(label: Text('status'),
           fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null,
          ),
            DataColumn2(label: Text('Amount'),
          ),
                 
          DataColumn2(label: Text('Action'),
          fixedWidth:  100 
          ),
        ],
        source: OrderRows(),
        
      );
      }
    );
  }
}