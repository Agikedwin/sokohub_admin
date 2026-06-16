
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/employee_garment_controller.dart';

class EmployeeGarmentAssignment extends StatelessWidget {
  const EmployeeGarmentAssignment({super.key});


  @override
  Widget build(BuildContext context) {
    final employee = CustomerController.instance;
    final  employeeGarmentController = EmployeeGarmentController.instance;
    return TRoundedContainer(
      child: Column(
        children: [         
            

                Obx(
                  () {
                    return MultiSelectDialogField(
                    buttonText: const Text('Assign Tailor'),
                    title: const Text('Tailor'),              
                    items: employee.allItems.map((emp) => MultiSelectItem(emp, emp.email)).toList(),
                    initialValue: List<UserModel>.from(employeeGarmentController.selectedEmployees),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values){
                      employeeGarmentController.selectedEmployees.assignAll(values);
                      employeeGarmentController.assignEmployeeGarment();
                    },
                     );
                  }
                )
           
            
        ],
      ),
    );
  }
}