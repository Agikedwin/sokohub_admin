import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';

class MeasuremntsWidgetPopup extends StatelessWidget {
  const MeasuremntsWidgetPopup({super.key});


  @override
  Widget build(BuildContext context) {

    final measurementController = Get.put(MeasurementController());
    return Obx(
      () => MultiSelectDialogField(
                buttonIcon: const Icon(Iconsax.add), // removes arrow
                    buttonText: const Text(''),
      
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                title: const Text('Measurements'),            
              
                items: measurementController.allItems.map((accessory) => MultiSelectItem(accessory, accessory.name)).toList(),
                initialValue:  measurementController.alreadySelectedMeasurement ,
                listType: MultiSelectListType.CHIP,
                onSelectionChanged: (value) => measurementController.assignNewMeasurement(value),
                onConfirm: (values) async{

                 await measurementController.addGarmentMeasurement();
                },
                 ),
    );
}
}