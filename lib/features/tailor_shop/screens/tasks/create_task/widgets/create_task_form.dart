import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';



import 'package:sokohub_admin/features/tailor_shop/controllers/task/create_task_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';


import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class CreateTasksForm extends StatelessWidget {
  const CreateTasksForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateTaskController()); 
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: createController.formKeyTask,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Create New Tasks', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: createController.name,
              validator: (value) => TValidator.validateEmptyText('Task Name', value),
              decoration: const InputDecoration(labelText: 'Tasks Name', prefixIcon: Icon(Iconsax.bag_2)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

            
            TextFormField(
              controller: createController.cost,
              validator: (value) => TValidator.validateEmptyText('Task Cost', value),
              decoration: const InputDecoration(labelText: 'Task Cost', prefixIcon: Icon(Iconsax.money)),
               keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,), 

             TextFormField(
              controller: createController.duration,
              validator: (value) => TValidator.validateEmptyText('Task Duration', value),
              decoration: const InputDecoration(labelText: 'Task Duration in hrs', prefixIcon: Icon(Iconsax.timer_11)),
               keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}$'),
                      ),
                    ],
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),              

             

                 Obx(
                   () => CheckboxMenuButton(
                    value: createController.isFeatured.value,
                    onChanged: (value) => createController.isFeatured.value = value ?? false, 
                    child: const Text('Featured')),
                 ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => createController.createTask(), child: const Text('Create')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
}