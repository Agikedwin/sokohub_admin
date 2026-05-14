import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/table/order_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/table/order_detail_table_source.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';



class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      columns:  [
        DataColumn2(
          label: Text('Order ID',),
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
}