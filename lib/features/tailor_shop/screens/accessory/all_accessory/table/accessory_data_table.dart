import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/table/accessory_table_source.dart';

class AccessoryTable extends StatelessWidget {
  const AccessoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccessoryController());
    return Obx(
      () {

        //Just to trigger chnaged when length chane during seraching hence redraws the screen
        Text( controller.filteredItems.length.toString());
         Text( controller.selectedRows.length.toString());
        return TPaginatedDataTable(
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value, 
        
        minWidth: 700,
        columns:  [
          DataColumn2(label: Text('Accessory'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Unit Cost')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: AccessoryRows(),
        
      );
      }
    );
  }
}