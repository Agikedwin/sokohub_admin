import 'package:get/get.dart';

import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_garment_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/employee_garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/task/employee_garment_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';



class EmployeeGarmentController  extends GetxController{

  static EmployeeGarmentController get instance => Get.find();

    

  final employeeGarmentRepository = Get.put(EmployeeGarmentRepository());
   
  final customerController = Get.put(CustomerController());
  RxBool empIsloading = false.obs;

  RxList<UserModel> selectedEmployees = <UserModel>[].obs;
  RxList<UserModel> alreadySelectedEmployees = <UserModel>[].obs;

  @override
  void onInit() {
    loadAssignedEmployee();
    super.onInit();
  }


Future<void> loadAssignedEmployee() async {
  try {
    empIsloading.value = true;

    final clientItemId = Get.parameters['clientGarmentId'];
    if (clientItemId == null) {
    }

    final employeeTasks =
        await employeeGarmentRepository.getAllAssignedById(clientItemId!);

    final employeeController = CustomerController.instance;

    if (employeeController.allCustomers.isEmpty) {
      await employeeController.fetchItems();
    }
    

    final employeeIds =
        employeeTasks.map((e) => e.employeeId).toSet();
    

    final employees = employeeController.allItems
        .where((emp) => employeeIds.contains(emp.id))
        .toList();

    selectedEmployees.assignAll(employees);
    alreadySelectedEmployees.assignAll(employees);

  } catch (e) {
  } finally {
    empIsloading.value = false;
  }
}

  void assignEmployeeGarment() async{

    try {
      final clientItemId = Get.parameters['clientGarmentId'];
      empIsloading.value = true;
      // Show progress dialog
      
      showProgressDialog();

      // Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      // Get existing emp Ids
      List<String> existingEmpIds = alreadySelectedEmployees.map((emp) => emp.id).toList();

      for (var employee in selectedEmployees) {
        // Check if the employee is not already associated with the client Item
        if(!existingEmpIds.contains(employee.id)){
          // Save Data
          final employeeGarment = EmployeeGarmentModel(
            id: '',
              clientItemId: clientItemId!,
              clientId: ClientGarmentOrderController.instance.clientGarmentSelection.value.id, 
              employeeId: employee.id
              );
        await employeeGarmentRepository.createEmployeeGarment(employeeGarment);
        }
        
      }

      // Remove categories not selected by the user
      for (var existingEmpId in existingEmpIds) {
        // Check if the Employee is not already associated with the product
        if(!selectedEmployees.any((emp) => emp.id == existingEmpId)){
          // Remove the association
          await employeeGarmentRepository.deleteEmployeeGarment(existingEmpId, clientItemId!);
        }
        
      }
       

      // Close the Progress Loader
      TFullScreenLoader.stopLoading();
       empIsloading.value = false;

      
    } catch (e) {
      TFullScreenLoader.stopLoading();
       empIsloading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  
  void showProgressDialog() {}
  
}