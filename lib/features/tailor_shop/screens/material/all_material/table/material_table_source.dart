import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MaterialRows extends DataTableSource{
  final controller = MaterialController.instance;
  @override
  DataRow? getRow(int index) {
   
   final material = controller.filteredItems[index];
   final parentMaterial = controller.allItems.firstWhereOrNull((item) => item.id == material.parentId);
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
                image: material.image,
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
              const SizedBox(width: TSizes.spaceBtwItems,),

              Expanded(
                child: Text(
                  material.name,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ), 
              )
            ],
          )
        ),
         DataCell(Text(parentMaterial != null ? parentMaterial.name : '')),
         DataCell(Text(material.unitCost > 0 ? material.unitCost.toString() : '')),
        DataCell( material.isFeatured ? const Icon(Iconsax.heart5, color: TColors.primary) : const Icon(Iconsax.heart),),
           DataCell(Text(material.createdAt == null ? '' : material.formattedDate)),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editMaterial, arguments: material),
                onDeletePressed: () => controller.confirmAndDeleteItem(material),
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