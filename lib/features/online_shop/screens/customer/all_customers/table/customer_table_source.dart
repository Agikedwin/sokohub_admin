import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerRows extends DataTableSource{
  final controller = CustomerController.instance;
  @override
  DataRow? getRow(int index) {
   final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(ITRoutes.customerDetail, arguments: customer, parameters: {'customerId': customer.id}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
               TRoundedImage(
                width: 50,
                height:50,
                padding: TSizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network ,
                borderRadius:  TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,

              ),
            const SizedBox(width: TSizes.spaceBtwItems,),

              Expanded(
                child: Text(
                  customer.fullName,
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ),
         DataCell(Text(customer.email)),
         DataCell(Text(customer.phoneNumber)),
         DataCell(Text(customer.createdAt == null ? '' : customer.formattedDate)),        
              DataCell(TTableActionButtons(
                view: true,
                edit: false, 
                onViewPressed: () => Get.toNamed(ITRoutes.customerDetail, arguments: customer, parameters: {'customerId': customer.id}),
                onDeletePressed: () => controller.confirmAndDeleteItem(customer),
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