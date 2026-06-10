import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/all_tasks/table/task_table_source.dart';

class TasksTable extends StatelessWidget {
  const TasksTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TasksController.instance;
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
          DataColumn2(label: Text('Task')),
          DataColumn2(label: Text('Cost')),
          DataColumn2(label: Text('Duration')),
          DataColumn2(label: Text('Date')),
          DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: TasksRows(),
        
      );
      }
    );
  }
}