import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';

class AccessoryWidgetPopup extends StatelessWidget {
  const AccessoryWidgetPopup({super.key});


  @override
  Widget build(BuildContext context) {

    final accessoryController = Get.put(AccessoryController());
    return Obx(
      () => MultiSelectDialogField(
                buttonIcon: const Icon(Iconsax.add), // removes arrow
                    buttonText: const Text(''),
      
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                title: const Text('Measurements'),            
              
                items: accessoryController.allItems.map((accessory) => MultiSelectItem(accessory, accessory.name)).toList(),
                initialValue:  accessoryController.alreadySelectedAccessory ,
                listType: MultiSelectListType.CHIP,
                onSelectionChanged: (value) => accessoryController.assignNewAccessory(value),
                onConfirm: (values) async{

                 await accessoryController.addGarmentAccessory();
                },
                 ),
    );
  }
}