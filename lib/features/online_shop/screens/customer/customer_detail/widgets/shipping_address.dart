import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_detail_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/address_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key, required this.customer,});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
     print('=============cutomer');
    print(customer.toJson());
    final controller = CustomerDetailController.instance;
    controller.getCustomersAddress();

    return  Obx(
      (){
        if(controller.addressLoading.value) return TLoaderAnimation();

        AddressModel selectedAddress = AddressModel.empty();

        if(controller.customer.value.addresses != null){
          if(controller.customer.value.addresses!.isNotEmpty){
            selectedAddress = controller.customer.value.addresses!.where((element) => element.selectedAddress).single;
          }
        }

        return TRoundedContainer(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Address', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),
      
            // meta data
      
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Name'),),
                Text(':'),
                 const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
                 Expanded(child: Text( selectedAddress.name ,style:  Theme.of(context).textTheme.titleMedium,)),
      
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems ,),
      
             Row(
              children: [
                const SizedBox(width: 120, child: Text('Country'),),
                Text(':'),
                 const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
                 Expanded(child: Text( selectedAddress.country,style:  Theme.of(context).textTheme.titleMedium,)),
      
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems ,),
      
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone Number'),),
                Text(':'),
                 const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
                 Expanded(child: Text( selectedAddress.phoneNumber,style:  Theme.of(context).textTheme.titleMedium,)),
      
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems ,),
      
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Address'),),
                Text(':'),
                 const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
                 Expanded(child: Text(selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '' ,style:  Theme.of(context).textTheme.titleMedium,)),
      
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems ,),
      
           
      
              ],
            )
      
            
      
        
             
          
        );
      }
    );
    
  }
}