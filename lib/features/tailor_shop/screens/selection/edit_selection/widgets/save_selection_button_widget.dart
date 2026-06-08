
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/edit_client_selection_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class SaveSelectionButtonWidget extends StatelessWidget {
  const SaveSelectionButtonWidget({super.key, required this.selection, });

  final ClientSelectionAttributesModel selection;

  @override
  Widget build(BuildContext context) {
    final controller = EditClientSelectionOrderController.instance;
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button

          OutlinedButton(onPressed: (){}, child: const Text('Discard')),
          SizedBox(width: TSizes.spaceBtwInputFields ,),

          //Save Changes button
          SizedBox(width: 160, child: ElevatedButton(onPressed: () => controller.editClientSelectionOrder(selection),
           child: const Text('Update')),)

          
             
        ],
      ),
    );
  }
}