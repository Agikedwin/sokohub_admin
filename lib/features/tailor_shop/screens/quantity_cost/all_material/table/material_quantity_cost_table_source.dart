import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';


class MaterialQuantityCostTableRow extends DataTableSource {
  final controller = GarmentSelectionController.instance;
  @override
  DataRow? getRow(int index) {
    final garmentSelection = controller.filteredItems[index];
//subTitle: '\ksh${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',


    // Calculations
   
   final totalCost = garmentSelection.material.estimatedLength! * garmentSelection.material.unitCost ;
   
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(ITRoutes.clientGarment, parameters: {'clientGarmentId': garmentSelection.id}),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
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
          DataCell(Text('${garmentSelection.material.estimatedLength!.toStringAsFixed(2)} m ')),
          DataCell(Text(garmentSelection.material.unitCost.toString())),
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
