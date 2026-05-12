import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/table/table_source.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 760,
      dataRowHeight: 64,
      columns:  [
        DataColumn2(
          label: Text('Brand',),
          fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200 ),
        DataColumn2(label: Text('Category'),
       
        ),
        DataColumn2(label: Text('Featured'),
        fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100 
        ),
        DataColumn2(label: Text('Date'),
        fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200 
        ),
        DataColumn2(label: Text('Action'),
        fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100 
        ),
      ],
      source: BrandRows(),
      
    );
  }
}