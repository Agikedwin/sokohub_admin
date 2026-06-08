import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/table/customer_order_table_source.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/table/order_detail_table_source.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';



class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 550,
      tableHeight: 465,
      dataRowHeight: kMinInteractiveDimension,
      columns:  [
        DataColumn2(
          label: Text('Order ID',),
          ),
        DataColumn2(label: Text('Date'),
       
        ),
        DataColumn2(label: Text('Items'),
        ),
         DataColumn2(label: Text('Status'),
         fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null
        ),
               
        DataColumn2(label: Text('Amount'),
        numeric: true,
        ),
      ],
      source: OrderDetailsRows(),
      
    );
  }
}