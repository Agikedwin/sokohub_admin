import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_screens/tablets/table_source.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: [
      DataColumn(label: Text('Order ID')),
       DataColumn(label: Text('Date')),
        DataColumn(label: Text('Items')),
         DataColumn(label: Text('Status')),
          DataColumn(label: Text('Amount'))

    ], source: OrderRows());
  }
}