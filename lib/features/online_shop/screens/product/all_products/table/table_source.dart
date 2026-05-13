import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class ProductRows extends DataTableSource{
  @override
  DataRow? getRow(int index) {
   
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                width: 50,
                height:50,
                padding: TSizes.sm,
                image: TImages.paypal,
                imageType: ImageType.asset ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
            const SizedBox(width: TSizes.spaceBtwItems,),

              Flexible(
                child: Text(
                  'Product Title',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ),
        const DataCell(Text('254')),

        DataCell(
          Row(
            children: [
              const TRoundedImage(
                width: 50,
                height:50,
                padding: TSizes.sm,
                image: TImages.paypal,
                imageType: ImageType.asset ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
            const SizedBox(width: TSizes.spaceBtwItems,),

              Flexible(
                child: Text(
                  'Puma',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ),
         const DataCell(Text('Ksh 896')),
           DataCell(Text(DateTime.now().toString())),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editProduct, arguments: BannerModel(name: '', imageUrl: '', active: false, targetScreen: ''), ),
                onDeletePressed: () => {},
              )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
  
}