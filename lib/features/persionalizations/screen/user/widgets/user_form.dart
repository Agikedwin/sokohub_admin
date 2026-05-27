import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/routes/app_screens.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCustomer = true;

    final controller = UserController.instance;
    
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Create User', style: Theme.of(context).textTheme.headlineSmall,),
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
                             controller: controller.email,
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

                     const SizedBox(height: TSizes.spaceBtwInputFields,),
                     
                     // Address details

                      Row(
                      children: [
                        // First name
                        Expanded(
                          child: TextFormField(
                             controller: controller.townAddress,
                            decoration: const InputDecoration(
                              
                              hintText: 'Town of Residence',
                              label: Text('Town'),
                              prefixIcon: Icon(Iconsax.location1)
                            ),
                            validator: (value) => TValidator.validateEmptyText('Town', value),
                          ),
                        ),
                         const SizedBox(width: TSizes.spaceBtwInputFields,),

                         Expanded(
                          child: TextFormField(
                            controller: controller.estateAddress,
                            decoration: const InputDecoration(
                              hintText: 'Place of residence',
                              label: Text('Estate'),
                              prefixIcon: Icon(Iconsax.home)
                            ),
                            validator: (value) => TValidator.validateEmptyText('Estate', value),
                          ),
                        ),
                      ],
                    ),

                      const SizedBox(height: TSizes.spaceBtwInputFields,),



                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Select User Type',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          Obx(
                            () => RadioGroup<String>(
                             groupValue: controller.userType.value,
                              onChanged: (value)  => controller.userType.value = value!,
                              
                              
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<String>(
                                      selectedTileColor: TColors.primary,
                                      contentPadding: EdgeInsets.zero,
                                      selected: false,
                                      dense: true,
                                      title: const Text('Customer'),
                                      value: 'Customer',
                                    ),
                                  ),
                            
                                  Expanded(
                                    child: RadioListTile<String>(
                                      contentPadding: EdgeInsets.zero,
                                      selectedTileColor: TColors.primary,
                                      dense: true,
                                      selected: true,
                                      title: const Text('User'),
                                      value: 'User',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                     const SizedBox(height: TSizes.spaceBtwSections,),


                    SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.loading.value ? {} : controller.createNewUser(),
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