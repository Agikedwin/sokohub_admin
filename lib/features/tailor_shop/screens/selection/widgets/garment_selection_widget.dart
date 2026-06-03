import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentSelectionWidget extends StatelessWidget {
  const GarmentSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final  garmentController = Get.put(GarmentController());

    // fetch Garment if the list is empty
    if(garmentController.allItems.isEmpty){
      garmentController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text('Garment', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          Obx(
            () => garmentController.isLoading.value 
            ?   const  TShimmerEffect(width: double.infinity, height: 40)
            : TypeAheadField(
              builder: (context, ctr, FocusNode){
                return TextFormField(
                  controller: garmentController.garmentTextField = ctr,
                  focusNode: FocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Garment',
                    suffixIcon:  Icon(Iconsax.shopping_cart5)
                  ),
                );
              }, 
              suggestionsCallback: (pattern){
                // Return filtered brands suggestions on the search pattern
                return garmentController.allItems.where((garment) => garment.name.contains(pattern)).toList();               
              },
              itemBuilder:(context, suggestion){
                return ListTile(title: Text(suggestion.name),);
              },
              onSelected: (suggestion){
                garmentController.selectedGarment.value = suggestion;
                garmentController.garmentTextField.text = suggestion.name;

                // Get list of measuremnts
                MeasurementController.instance.getEnteredValues(suggestion);
                AccessoryController.instance.getEnteredValues(suggestion);
              }, 
              
              ) 
          )
        ],
      ),
    );
  }
}