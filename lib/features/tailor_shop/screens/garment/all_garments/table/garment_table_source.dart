import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentRows extends DataTableSource{
  final controller = GarmentController.instance;
  @override
  DataRow? getRow(int index) {
   
   final garment = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ITRoutes.garmentInfo, arguments: garment),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
               TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                image: garment.image,
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
              const SizedBox(width: TSizes.spaceBtwItems,),

              Expanded(
                child: Text(
                  garment.name,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ), 
              )
            ],
          )
        ),
         DataCell(Text(garment.wage.toString())),

        DataCell( garment.isFeatured ? const Icon(Iconsax.heart5, color: TColors.primary) : const Icon(Iconsax.heart),),
           DataCell(Text(garment.createdAt == null ? '' : garment.formattedDate)),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editGarment, arguments: garment),
                onDeletePressed: () => controller.confirmAndDeleteItem(garment),
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