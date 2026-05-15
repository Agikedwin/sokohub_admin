import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First name
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              label: Text('First Name'),
                              prefixIcon: Icon(Iconsax.user)
                            ),
                            validator: (value) => TValidator.validateEmptyText('First Name', value),
                          ),
                        ),
                         const SizedBox(height: TSizes.spaceBtwSections,),

                         Expanded(
                          child: TextFormField(
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
                         const SizedBox(height: TSizes.spaceBtwItems,),

                         Expanded(
                          child: TextFormField(
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
                      child: ElevatedButton(onPressed: () {
                        
                      }, 
                      child:  const Text('Update Profile')),
                     )

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