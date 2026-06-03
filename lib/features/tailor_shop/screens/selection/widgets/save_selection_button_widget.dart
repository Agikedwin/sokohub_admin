
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class SaveSelectionButtonWidget extends StatelessWidget {
  const SaveSelectionButtonWidget({super.key, });

  

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button

          OutlinedButton(onPressed: (){}, child: const Text('Discard')),
          SizedBox(width: TSizes.spaceBtwInputFields ,),

          //Save Changes button
          SizedBox(width: 160, child: ElevatedButton(onPressed: () =>{},
           child: const Text('Save')),)

          
             
        ],
      ),
    );
  }
}