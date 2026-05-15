import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),

          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: TSizes.spaceBtwSections),


                // App Name
                TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'App Name',
                          label: Text('App Name'),
                          prefixIcon: Icon(Iconsax.activity),
                        ),
                        validator: (value) =>
                            TValidator.validateEmptyText(
                              'App Name',
                              value,
                            ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Tax',
                          label: Text('Tax Rate %'),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                        validator: (value) =>
                            TValidator.validateEmptyText(
                              'Tax',
                              value,
                            ),
                      ),
                    ),

                    const SizedBox(width: TSizes.spaceBtwItems),

                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          label: Text('Shipping Cost'),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                        validator: (value) =>
                            TValidator.validateEmptyText(
                              'Last Name',
                              value,
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections),

                // Email & Phone
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Free Shipping After',
                          label: Text('Free Shipping Threshold'),
                          prefixIcon: Icon(Iconsax.direct),
                        ),
                        validator: (value) =>
                            TValidator.validateEmptyText(
                              'Free Shipping',
                              value,
                            ),
                      ),
                    ),

                    const SizedBox(width: TSizes.spaceBtwItems),

                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Free Cost',
                          label: Text('Free Cost'),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                        validator: (value) =>
                            TValidator.validateEmptyText(
                              'Shipping Cost',
                              value,
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Update Settings'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}