import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/table/table_source.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/table/material_table_source.dart';

class MaterialTable extends StatelessWidget {
  const MaterialTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaterialController());
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
          DataColumn2(label: Text('Material'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Parent'), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending)),
          DataColumn2(label: Text('Unit Cost')),
          DataColumn2(label: Text('Featured')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: MaterialRows(),
        
      );
      }
    );
  }
}