import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/banner/banner_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class BannerRows extends DataTableSource{

  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
   
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ITRoutes.editBanner, arguments: banner),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
               TRoundedImage(
                width: 80,
                height:80,
                padding: TSizes.sm,
                image: banner.imageUrl,
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
              SizedBox(height: TSizes.spaceBtwItems /2,)
            
            ],
          )
        ),
         DataCell(Text(controller.formatRoute(banner.targetScreen))),
          DataCell(banner.active ? const Icon(Iconsax.eye, color: TColors.primary,) : const Icon(Iconsax.eye_slash)),

              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editBanner, 
                arguments: banner, ),
                onDeletePressed: () => controller.confirmAndDeleteItem(banner),
              )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
  
}