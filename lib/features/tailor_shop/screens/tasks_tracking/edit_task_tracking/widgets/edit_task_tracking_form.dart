import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/chips/rounded_choice_chips.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';

import 'package:sokohub_admin/features/tailor_shop/controllers/task/edit_task_tracking_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/employee_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditTaskTrackingForm extends StatelessWidget {
  const EditTaskTrackingForm({super.key, required this.tasks});

  final TaskModel tasks;

  @override
  Widget build(BuildContext context) {
    final assignedEmpController = EmployeeGarmentController.instance;
    // Fetch employees assigned to this garments tasks
    assignedEmpController.loadAssignedEmployee();
     final  controller = EditTaskTrackingController.instance;
     // Set field values
     controller.init(tasks);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm,),
            Text('Update Task', style:  Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwSections ,),

            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Task Name', value),
              decoration: const InputDecoration(labelText: 'Task Name', prefixIcon: Icon(Iconsax.box)),
            ),

             const SizedBox(height: TSizes.spaceBtwInputFields  ,),

             // Categories

             Text('Task Assiged to', style:  Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),



             Obx(
               () =>  assignedEmpController.alreadySelectedEmployees.isEmpty ? TShimmerEffect(width: double.infinity, height: 40) : Wrap(
                spacing: TSizes.sm,
                children: assignedEmpController.alreadySelectedEmployees
                .map((employee) =>  Padding(
                    padding: EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(text: employee.firstName, 
                     selected: assignedEmpController.alreadySelectedEmployees.contains(employee),
                     //onSelected: (value)=> assignedEmpController.toggleSelection(employee),
                     ),
                  ),                
                ).toList()
               ),
             ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),

              Text('Task done By', style:  Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),



             Obx(
               () =>  assignedEmpController.alreadySelectedEmployees.isEmpty ? TShimmerEffect(width: double.infinity, height: 40) : Wrap(
                spacing: TSizes.sm,
                children: CustomerController.instance.allCustomers
                .map((employee) =>  Padding(
                    padding: EdgeInsets.only(bottom: TSizes.sm),
                    child: TChoiceChip(text: employee.firstName, 
                     selected: assignedEmpController.selectedEmployees.contains(employee),
                     onSelected: (value)=> assignedEmpController.toggleSelection(employee),),
                  ),                
                ).toList()
               ),
             ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),

             

               Obx(() => CheckboxMenuButton(
                value: controller.isCompleted.value, 
                onChanged: (value){
                  controller.isCompleted.value = value ?? false;
                }, 
                child: const Text('Completed'))
                ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.updateTaskTracking(tasks), 
                    child: const Text('Save')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
          ],
        ),
      ),
    );
  }
  }
  
