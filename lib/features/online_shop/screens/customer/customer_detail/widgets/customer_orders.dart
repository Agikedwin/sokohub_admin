import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/table/customer_order_table.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key,});


  @override
  Widget build(BuildContext context) {
    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Orders', style:  Theme.of(context).textTheme.headlineMedium,),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Total Spent'),
                TextSpan(text: '\$600.90', style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary)),
                 TextSpan( text: ' on ${5} Orders', style:  Theme.of(context).textTheme.bodyLarge,),
              ]
            )
          ),
            ],
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems ,),

          TextFormField(
            onChanged: (query){},
            decoration: const InputDecoration(hintText: 'Search Orders', prefixIcon: Icon(Iconsax.search_normal)),
          ),
          const SizedBox(height: TSizes.spaceBtwSections ,),

          const CustomerOrderTable()

            ],
          )

        
      );
    
  }
}