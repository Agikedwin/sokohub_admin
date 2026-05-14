import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerRows extends DataTableSource{
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
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
            const SizedBox(width: TSizes.spaceBtwItems,),

              Expanded(
                child: Text(
                  'Agik Edwin',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ),
        const DataCell(Text('agikedwin@gmail.com')),
        const DataCell(Text('+254-7174 890989')),
         DataCell(Text(DateTime.now().toString())),        
              DataCell(TTableActionButtons(
                view: true,
                edit: false, 
                onViewPressed: () => Get.toNamed(ITRoutes.customerDetail, arguments: UserModel.empty()),
                onDeletePressed: () => {},
              )),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
  
}