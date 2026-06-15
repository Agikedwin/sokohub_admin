import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/chips/rounded_choice_chips.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/edit_category_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/edit_task_tracking_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/employee_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/validators/validation.dart';

class EditTaskTrackingForm extends StatelessWidget {
  const EditTaskTrackingForm({super.key, required this.tasks});

  final ClientSelectionAttributesModel tasks;

  @override
  Widget build(BuildContext context) {
    final assignedEmpController = EmployeeGarmentController.instance;
    assignedEmpController.loadAssignedEmployee();
     final  controller = EditTaskTrackingController.instance;
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

             Text('Task done By', style:  Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2 ,),

             Obx(
               () => Wrap(
                spacing: TSizes.sm,
                children: assignedEmpController.selectedEmployees
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
                child: const Text('Featured'))
                ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => {}, //controller.updateTaskTracking(), 
                    child: const Text('Update')),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields * 2  ,),
          ],
        ),
      ),
    );
  }
  }
  
