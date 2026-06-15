import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks_tracking/all_tasks_tracking/table/tasks_tracking_table_source.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class TasksTrackingDataTable extends StatelessWidget {
  const TasksTrackingDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GarmentSelectionController());
    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
         Text(controller.selectedRows.length.toString());

       //  final lgTable = controller.filteredItems.any((elemet) => elemet.brandCategory != null && elemet.brandCategory!.length >2);

        return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760, //lgTable ? 96 * 11.5 : 64,
        dataRowHeight: 64, // lgTable ? 96 : 64,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value, 
        columns:  [
          DataColumn2(
            label: Text('Task Name',),
            fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200 ),
          DataColumn2(label: Text('Wage'),
         
          ),
          DataColumn2(label: Text('Duration(hrs)'),
          fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100 
          ),
          DataColumn2(label: Text('Status'),
          fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 200 
          ),
          DataColumn2(label: Text('Action'),
          fixedWidth: TDeviceUtils.isMobileScreen(Get.context!) ? null : 100 
          ),
        ],
        source: TasksTrackingTableSourceRows(),
        
      );
      }
    );
  }
}