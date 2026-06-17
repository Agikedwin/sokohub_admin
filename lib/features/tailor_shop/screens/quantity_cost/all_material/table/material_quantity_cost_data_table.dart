import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/quantity_cost/all_material/table/material_quantity_cost_table_source.dart';

class MaterialQuantityCostTable extends StatelessWidget {
  const MaterialQuantityCostTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GarmentSelectionController());
    if (controller.allItems.isNotEmpty) {
      
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
              label: Text('Material'),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Length')),
          DataColumn2(label: Text('Unit Cost')),
          DataColumn2(label: Text('Total')),
          DataColumn2(label: Text('Tasks')),
        ],
        source: MaterialQuantityCostTableRow(),
      );
    });
  }
}
