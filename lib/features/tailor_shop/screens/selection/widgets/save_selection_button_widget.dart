
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_selection_order_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class SaveSelectionButtonWidget extends StatelessWidget {
  const SaveSelectionButtonWidget({super.key, });

  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientSelectionOrderController());
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button

          OutlinedButton(onPressed: (){}, child: const Text('Discard')),
          SizedBox(width: TSizes.spaceBtwInputFields ,),

          //Save Changes button
          SizedBox(width: 160, child: ElevatedButton(onPressed: () => controller.createClientSelectionOrder(),
           child: const Text('Save')),)

          
             
        ],
      ),
    );
  }
}