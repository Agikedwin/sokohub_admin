import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_accessories/table/accessories_quantity_cost_table_source.dart';

class AccessoryQuantityCostTable extends StatelessWidget {
  const AccessoryQuantityCostTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GarmentSelectionController());
    if (controller.allItems.isEmpty) {
      //controller.fetchItems();
    }

    return Obx(() {
      
     
      //Just to trigger chnaged when length chane during seraching hence redraws the screen
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return TPaginatedDataTable(
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        minWidth: 700,
        columns: [
          
          DataColumn2(
              label: Text('Garment'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
                  DataColumn2(label: Text('Accessory'), fixedWidth: 500),
          DataColumn2(label: Text('Quantity(cm)')),
          DataColumn2(label: Text('Unit Cost')),
          DataColumn2(label: Text('Total')),
          DataColumn2(label: Text('Tasks')),
        ],
        source: AccessoryQuantityCostTableRow(),
      );
    });
  }
}
