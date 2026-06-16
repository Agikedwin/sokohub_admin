import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentSelectionRows extends DataTableSource {
  final controller = GarmentSelectionController.instance;
  @override
  DataRow? getRow(int index) {
    final garmentSelection = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(ITRoutes.clientGarment, parameters: {'clientGarmentId': garmentSelection.id}),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: garmentSelection.garment.image,
                imageType: ImageType.network,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              
              Expanded(
                child: Text(
                  garmentSelection.clientOrder.title,
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
          DataCell(Text(garmentSelection.garment.name)),
          DataCell(Text(garmentSelection.material.name)),
          DataCell(Text(garmentSelection.client!.fullName == ''
              ? garmentSelection.client!.fullName
              : garmentSelection.client!.email)),
          DataCell(Text(garmentSelection.orderId)),
          DataCell(Text(garmentSelection.orderDate.toString())),
          DataCell(TTableActionButtons(
            onEditPressed: () => Get.toNamed(ITRoutes.editGarmentSelection,
                arguments: garmentSelection),
            onDeletePressed: () =>
                controller.confirmAndDeleteItem(garmentSelection),
          )),
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
