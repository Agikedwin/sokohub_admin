import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/create_material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class MaterialSelectionWidget extends StatelessWidget {
  const MaterialSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final  materialController = Get.put(MaterialController());
    final createMaterialController  = Get.put(CreateMaterialController());

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
                return TextFormField(
                  controller: materialController.materialTextField = ctr,
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
          ),
           const SizedBox(height: TSizes.spaceBtwInputFields  ,),   
          TextFormField(
              controller: createMaterialController.estimatedLength,
              validator: (value) => TValidator.validateEmptyText('Estimated Length(m)', value),
              decoration: const InputDecoration(labelText: 'Estimated Length(m)', prefixIcon: Icon(Iconsax.size5)),
               keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),       

          
        ],
      ),
    );
  }
}