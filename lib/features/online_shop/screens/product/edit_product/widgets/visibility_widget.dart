import 'package:flutter/material.dart';

import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';



class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product visibility header
          Text(
            'Visibility',
            style: Theme.of(context).textTheme.headlineSmall,
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Radio buttons for product visibility
          Column(
            children: [
              _buildVisibilityRadioButton(
                ProductVisibility.published,
                'Published',
              ),
              _buildVisibilityRadioButton(
                ProductVisibility.hidden,
                'Hidden',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build a radio button for product visibility
  Widget _buildVisibilityRadioButton(
    ProductVisibility value,
    String label,
  ) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: ProductVisibility.published,
      onChanged: (selection) {},
      child: Text(label),
    );
  }
}