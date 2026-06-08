import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MaterialSelectionWidget extends StatelessWidget {
  const MaterialSelectionWidget({super.key, required this.material});

  final MaterialModel material;

  @override
  Widget build(BuildContext context) {
    final  materialController = Get.put(MaterialController());

    // fetch brands if the list is empty
    if(materialController.allItems.isEmpty){
      materialController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text('Material', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          Obx(
            () => materialController.isLoading.value 
            ?   const  TShimmerEffect(width: double.infinity, height: 40)
            : TypeAheadField(
              builder: (context, ctr, FocusNode){
                if(material.id != '' || material.name != ''){
                  ctr.text = material.name;
                }
                materialController.materialTextField = ctr;
                return TextFormField(
                  controller: ctr,
                  focusNode: FocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Material',
                    suffixIcon:  Icon(Iconsax.scissor)
                  ),
                );
              }, 
              suggestionsCallback: (pattern){
                // Return filtered brands suggestions on the search pattern
                return materialController.allItems.where((garment) => garment.name.contains(pattern)).toList();               
              },
              itemBuilder:(context, suggestion){
                return ListTile(title: Text(suggestion.name),);
              },
              onSelected: (suggestion){
                materialController.selectedMaterial.value = suggestion;
                materialController.materialTextField.text = suggestion.name;
              }, 
              
              ) 
          )
        ],
      ),
    );
  }
}