import 'package:flutter/material.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Product Type', style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(width: TSizes.spaceBtwItems,),

        // radio buttons for single product type
        RadioMenuButton(value: ProductType.single, groupValue: ProductType.single, 
        onChanged: (value) => {}, 
        child: const Text('Single')),

        // radio buttons for variable product type
        RadioMenuButton(value: ProductType.single, groupValue: ProductType.single, 
        onChanged: (value) => {}, 
        child: const Text('Variable'))
      ],
    );
  }
}