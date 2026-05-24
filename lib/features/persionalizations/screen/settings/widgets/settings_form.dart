import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/setting_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingController.instance;
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: TSizes.lg,
            horizontal: TSizes.md,
          ),

          child: Form(
            key: controller.formKey,
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
                  controller: controller.appNameController,
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
                         controller: controller.taxController,
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
                         controller: controller.shippingController,
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          label: Text('Shipping Cost'),
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

                // Email & Phone
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                         controller: controller.freeShippingThresholdController,
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

                   
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.loading.value ? {} : controller.updateSettingInformation(),
                      child: controller.loading.value 
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2,) 
                      : const Text('Update Settings'),
                    ),
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