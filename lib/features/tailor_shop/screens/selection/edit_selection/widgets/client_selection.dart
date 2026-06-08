import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ClientSelection extends StatelessWidget {
  const ClientSelection({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final  clientController = Get.put(CustomerController());

    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text('Client', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          Obx(
            () => clientController.isLoading.value 
            ?   const  TShimmerEffect(width: double.infinity, height: 40)
            : TypeAheadField(
              builder: (context, ctr, FocusNode){
                // Set default valies
                if(user.id != '' || user.email != '' || user.fullName != ''){
                  ctr.text = user.email; 
                }
                      

                clientController.selectedTextController = ctr;

                return TextFormField(
                  controller: ctr, // clientController.selectedTextController = ctr,
                  focusNode: FocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Client',
                    suffixIcon:  Icon(Iconsax.user)
                  ),
                );
              }, 
              suggestionsCallback: (pattern){
                // Return filtered brands suggestions on the search pattern
                return clientController.allItems.where((garment) =>  garment.email.toLowerCase().contains(pattern.toLowerCase())).toList();               
              },
              itemBuilder:(context, suggestion){
                return ListTile(title: Text(suggestion.email),);
              },
              onSelected: (suggestion){
                clientController.selectedClient.value = suggestion;
                clientController.selectedTextController.text = suggestion.email; 

                
              }, 
              
              ) 
          )
        ],
      ),
    );
  }
}