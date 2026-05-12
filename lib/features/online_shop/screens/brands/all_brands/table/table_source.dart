import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class BrandRows extends DataTableSource{
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

              Expanded(
                child: Text(
                  'Adidas',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ),
         DataCell(
          Padding(
            padding: EdgeInsets.symmetric(vertical: TSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: TSizes.xs,
                direction: TDeviceUtils.isMobileScreen(Get.context!) ? Axis.vertical : Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs) ,
                    child: const Chip(label: Text('Shoes'), padding: EdgeInsets.all(TSizes.xs),),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs) ,
                    child: const Chip(label: Text('TrackSuits'), padding: EdgeInsets.all(TSizes.xs),),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: TDeviceUtils.isMobileScreen(Get.context!) ? 0 : TSizes.xs) ,
                    child: const Chip(label: Text('Blazzers'), padding: EdgeInsets.all(TSizes.xs),),
                  )
                ],
              ),
            ),
          )
         ),


        const  DataCell(Icon(Iconsax.heart5, color: TColors.primary,)),
           DataCell(Text(DateTime.now().toString())),
              DataCell(TTableActionButtons(
                onEditPressed: () => Get.toNamed(ITRoutes.editBrand, arguments: ''),
                onDeletePressed: () => {},
              )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
  
}