import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';


class AccessoryQuantityCostTableRow extends DataTableSource {
  final controller = GarmentSelectionController.instance;
  @override
  DataRow? getRow(int index) {
    final garmentSelection = controller.filteredItems[index];
//subTitle: '\ksh${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',


    // Calculations
   final accessoryQuantity = garmentSelection.accessories.fold(0.0, (previousValue, item) => previousValue + item.unitCost);
   final totalCost = accessoryQuantity * garmentSelection.material.unitCost / 100;
    return DataRow2(
        onTap: () => Get.toNamed(ITRoutes.clientGarment, parameters: {'clientGarmentId': garmentSelection.id}),
        
        cells: [
          DataCell(Row(
            children: [
                           
              Expanded(
                child: Text(
                  garmentSelection.material.name,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
          DataCell(Row(
            children: [
                           
              Expanded(
              
                child: Wrap(
                  children: garmentSelection.accessories.map((item) => Padding(
                                padding: EdgeInsetsGeometry.all(
                                     TDeviceUtils.isMobileScreen(
                                            Get.context!)
                                        ? 0
                                        : TSizes.xs),
                                        
                                child: Chip(
                                  label: Text('${item.name} ${item.quantity}'),
                                  padding: EdgeInsets.all(TSizes.xs),
                                ),
                              ),).toList(),
                ),
                
              )
            ],
          )),
          DataCell(Text(garmentSelection.accessories.fold<double>(0.0, (previousValue, item) => previousValue + item.quantity!).toStringAsFixed(1))),
          DataCell(Text(garmentSelection.accessories.fold<double>(0.0, (previousValue, item) => previousValue + item.unitCost).toStringAsFixed(1))),
          DataCell(Text(totalCost.toStringAsFixed(1))),
         
          DataCell(TTableActionButtons(view: true, delete: false, edit: false,
            onViewPressed: () => Get.toNamed(ITRoutes.garmentTasks, arguments: garmentSelection))),
           
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected = selected).length;
}
