import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class AccessoryRows extends DataTableSource{
  final controller = AccessoryController.instance;
  @override
  DataRow? getRow(int index) {
   
   final accessory = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
               TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: accessory.image,
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
              const SizedBox(width: TSizes.spaceBtwItems,),

              Expanded(
                child: Text(
                  accessory.name,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ), 
              )
            ],
          )
        ),
         DataCell(Text(accessory.unitCost > 0 ? accessory.unitCost.toString() : '')),
           DataCell(Text(accessory.createdAt == null ? '' : accessory.formattedDate)),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editAccessory, arguments: accessory),
                onDeletePressed: () => controller.confirmAndDeleteItem(accessory),
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