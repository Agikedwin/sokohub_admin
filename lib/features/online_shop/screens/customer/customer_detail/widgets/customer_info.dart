import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, });

  //final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Customer Infomation', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),
      
          
          Row(
            children: [
              TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: TImages.user,
                imageType: ImageType.asset,
              ),

               const SizedBox(height: TSizes.spaceBtwItems ,),

           Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Agik edwin', style:  Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1,),
                 const Text('Agik edwin',  overflow: TextOverflow.ellipsis, maxLines: 1,),
              ],
            ),
           )

            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems ,),

          // meta data

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( 'Apuoyo',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems /2 ,),

           Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number'),),
              Text(':'),
               const SizedBox(height: TSizes.spaceBtwItems / 2 ,),
               Expanded(child: Text( '+254-569-897866',style:  Theme.of(context).textTheme.titleMedium,)),

            ],
          ),
          Divider(height: 10,),
          const SizedBox(height: TSizes.spaceBtwItems ,),

          // Additional Details
          Row(
            children: [
              Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Last Order', style:  Theme.of(context).textTheme.titleLarge),
                 const Text('7 days ago #[23TRO]' ,  ),
              ],
            ),
           ),
           Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Average Value Order', style:  Theme.of(context).textTheme.titleLarge),
                 const Text('\$890' ,  ),
              ],
            ),
           )

            ],
          ),
           const SizedBox(height: TSizes.spaceBtwItems ,),

           // Additional details cont
           Row(
            children: [
              Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Registered', style:  Theme.of(context).textTheme.titleLarge),
                  Text('customer.formattedDate '),
              ],
            ),
           ),
           Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Email Marketing', style:  Theme.of(context).textTheme.titleLarge),
                 const Text('Subscribed' ,  ),
              ],
            ),
           )

            ],
          ),

            ],
          )

          

      
           
        
      );
    
  }
}