import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key,});

 // final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Shipping Address', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),
      
          
          


          // meta data

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Name'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( 'Mbita',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems ,),

           Row(
            children: [
              const SizedBox(width: 120, child: Text('Country'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( 'MigingoS',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems ,),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( '89077800',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems ,),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Address'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( 'Migingo',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems ,),

         

            ],
          )

          

      
           
        
      );
    
  }
}