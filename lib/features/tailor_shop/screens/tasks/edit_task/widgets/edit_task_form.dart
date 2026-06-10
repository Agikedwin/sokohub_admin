import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/edit_task_controller.dart';



import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditTasksForm extends StatelessWidget {
  const EditTasksForm({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final editController = EditTaskController.instance;
    editController.init(task);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Create New Tasks', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: editController.name,
              validator: (value) => TValidator.validateEmptyText('Task Name', value),
              decoration: const InputDecoration(labelText: 'Tasks Name', prefixIcon: Icon(Iconsax.category)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),


            TextFormField(
              controller: editController.cost,
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
              controller: editController.duration,
              validator: (value) => TValidator.validateEmptyText('Task Duration', value),
              decoration: const InputDecoration(labelText: 'Task Duration in hrs', prefixIcon: Icon(Iconsax.money)),
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
                    value: editController.isFeatured.value,
                    onChanged: (value) => editController.isFeatured.value = value ?? false, 
                    child: const Text('Featured')),
                 ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => editController.updateTask(task), child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),



          ],
        ),
      ),
    );
  }
  }
