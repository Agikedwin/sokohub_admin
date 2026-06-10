import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';


class TasksRows extends DataTableSource{
  final controller = TasksController.instance;
  @override
  DataRow? getRow(int index) {
   
   final task = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ITRoutes.task, arguments: task),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
               

              Expanded(
                child: Text(
                  task.name,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ), 
              )
            ],
          )
        ),
         DataCell(Text(task.cost.toString())),

        DataCell(Text(task.duration.toString())),
           DataCell(Text(task.formattedDate)),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editTask, arguments: task),
                onDeletePressed: () => controller.confirmAndDeleteItem(task),
              )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected = selected).length;
  
}