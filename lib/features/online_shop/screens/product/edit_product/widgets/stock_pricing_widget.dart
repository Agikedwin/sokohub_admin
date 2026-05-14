import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProoductStockAndPricingWidget extends StatelessWidget {
  const ProoductStockAndPricingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Stock
          FractionallySizedBox(
            widthFactor: 0.45,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Stock',
                hintText: 'Add Stock, only numbers are allowed',
              ),
              validator: (value) =>
                  TValidator.validateEmptyText('Stock', value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Pricing
          Row(
            children: [
              /// Price
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price up to 2 decimals',
                  ),
                  validator: (value) =>
                      TValidator.validateEmptyText('Price', value),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}$'),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: TSizes.spaceBtwInputFields),

              /// Discounted Price
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Discounted Price',
                    hintText: 'Price up to 2 decimals',
                  ),
                  validator: (value) =>
                      TValidator.validateEmptyText(
                    'Discounted Price',
                    value,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}$'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}