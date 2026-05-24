import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
     controller.lastNameController.text = controller.user.value.lastName;
      controller.phoneController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Profile Details', style: Theme.of(context).textTheme.headlineSmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // First and last name

              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First name
                        Expanded(
                          child: TextFormField(
                             controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              
                              hintText: 'First Name',
                              label: Text('First Name'),
                              prefixIcon: Icon(Iconsax.user)
                            ),
                            validator: (value) => TValidator.validateEmptyText('First Name', value),
                          ),
                        ),
                         const SizedBox(width: TSizes.spaceBtwInputFields,),

                         Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              label: Text('Last Name'),
                              prefixIcon: Icon(Iconsax.user)
                            ),
                            validator: (value) => TValidator.validateEmptyText('Last Name', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections,),

                    // Email and password
                    Row(
                      children: [
                        // First name
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              prefixIcon: Icon(Iconsax.forward)
                            ),
                            validator: (value) => TValidator.validateEmptyText('Email', value),
                          ),
                        ),
                          const SizedBox(width: TSizes.spaceBtwInputFields,),

                         Expanded(
                          child: TextFormField(
                             controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              label: Text('Phone Number'),
                              prefixIcon: Icon(Iconsax.mobile)
                            ),
                            validator: (value) => TValidator.validateEmptyText('Phone Number', value),
                          ),
                        ),
                      ],
                    ),

                     const SizedBox(height: TSizes.spaceBtwSections,),

                    SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.loading.value ? {} : controller.updateUserInformation(),
                      child: controller.loading.value 
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2,) 
                      : const Text('Update Profile'),
                    ),
                  ),
                ),

                  ],
                ),
              )
              
            ],
          ),
        ),
      ],
    );
  }
}