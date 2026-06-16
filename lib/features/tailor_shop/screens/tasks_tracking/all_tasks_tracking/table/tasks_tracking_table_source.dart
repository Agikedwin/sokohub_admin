import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class TasksTrackingTableSourceRows extends DataTableSource {
  // Get selected item from the arguments passed
  ClientSelectionAttributesModel tracking = Get.arguments;
  @override
  DataRow? getRow(int index) {
    
    final tasksTracker = tracking.garmentTasks![index];

    return DataRow2(

        //selected: controller.selectedRows[index],
        //onSelectChanged: (value) => controller.selectedRows[index] =value ?? false,
        cells: [
          DataCell(
              onTap: () => {},
              Row(
                children: [
                  Text(
                    tasksTracker.name,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )),
          DataCell(Padding(
            padding: EdgeInsets.symmetric(vertical: TSizes.sm),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                    spacing: TSizes.xs,
                    direction: TDeviceUtils.isMobileScreen(Get.context!)
                        ? Axis.vertical
                        : Axis.horizontal,
                    children: tasksTracker.doneBy != null
                        ? tasksTracker.doneBy!
                            .map(
                              (e) => Padding(
                                padding: EdgeInsetsGeometry.only(
                                    bottom: TDeviceUtils.isMobileScreen(
                                            Get.context!)
                                        ? 0
                                        : TSizes.xs),
                                child: Chip(
                                  label: Text(e.firstName),
                                  padding: EdgeInsets.all(TSizes.xs),
                                ),
                              ),
                            )
                            .toList()
                        : [const SizedBox()])),
          )),
          DataCell(Text(tasksTracker.formattedDate)),
          DataCell(Text(tasksTracker.completedAt.toString())),
          DataCell(Text(tasksTracker.duration.toString())),
          DataCell(tasksTracker.status == 'Pending'
              ? const Icon(
                  Iconsax.timer_1,
                  color: TColors.primary,
                )
              : const Icon(
                  Iconsax.tick_circle,
                  color: TColors.success,
                )),
          DataCell(TTableActionButtons( 
            onEditPressed: () {
              Get.toNamed(ITRoutes.editGarmentTasks, arguments: tasksTracker, parameters: {'clientGarmentId': tracking.id});
              // set selected Item
              GarmentSelectionController.instance.selectedGarmentSelection(tracking);

            }
                

            //view: ,
            // onDeletePressed: () => controller.confirmAndDeleteItem(),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tracking.garmentTasks!.length;

  @override
  int get selectedRowCount => 0;
}
