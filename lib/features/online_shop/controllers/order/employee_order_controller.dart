import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/data/repositories/order/employee_order_repository.dart';
import 'package:sokohub_admin/data/repositories/order/order_repository.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/cart_item_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/models/employee_order_assignment_model.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';



class EmployeeOrderController  extends TBaseController<EmployeeOrderAssignmentModel>{

  static EmployeeOrderController get instance => Get.find();

    

  final empOrderRepository = Get.put(EmployeeOrderRepository());
   
  final customerController = Get.put(CustomerController());
  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.pending.obs;
  RxList<UserModel> userAssigned = <UserModel>[].obs;
  RxList<UserModel> userAssignedAlready = <UserModel>[].obs;


  @override
  Future<List<EmployeeOrderAssignmentModel>> fetchItems()  async{
    sortAscending.value = false;
    final data = await empOrderRepository.getAllEmployeeAssignments();

    final employee = customerController.allCustomers;
    userAssignedAlready.assignAll(employee);
    final allreadyAssined = await getCommonAssignments(data, employee);

    print(employee.toJson());
    print('===============iiiiiiiiiiii');
    print(data);
    print(allreadyAssined.first.fullName);

    // Map existing ids to a user model
    List<UserModel> listUser = [];

    for (var orderEmp in allreadyAssined){
     print('----------------jjj');
     final userFound = UserModel(
      id: orderEmp.orderId ?? '', 
      email: '',
      firstName: orderEmp.fullName ?? '',
       isEmailVerified: false,
        isProfileActive: false
        );
        print('----------ss333------${orderEmp.orderId}');
        listUser.add(userFound);
        print('----------ss------jjj ${orderEmp.fullName}');
    }
    

 
    userAssigned.assignAll(listUser);
     print('----------333------jjj');
    print(userAssigned.first.fullName);
    
    return data;
  }

  Future<List<EmployeeOrderAssignmentModel>> getCommonAssignments (
  List<EmployeeOrderAssignmentModel> listA,
  List<UserModel> listB,
)  async {
  
  // 1. Extract all userIds from the first list into a Set for O(1) lookups
  final Set<String> userIdsInA = listB.map((item) => item.id).toSet();


  // 2. Filter the second list, keeping only items whose userId exists in the Set
  // .where() returns an Iterable, so we use .toList() at the end
  return  listA.where((item) => userIdsInA.contains(item.userId)).toList();
}


  @override
  bool containsSearchQuery(EmployeeOrderAssignmentModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase()) || item.id.toString().toLowerCase().contains(query.toLowerCase()) || item.userId.toString().toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(EmployeeOrderAssignmentModel item) async{
     await empOrderRepository.deleteUserAssignment(item.id);
  }
  ///Sorting
  void sortById(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (EmployeeOrderAssignmentModel order) => order.userId.toString().toLowerCase());
  }

   ///Sorting
  void sortByDate(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (EmployeeOrderAssignmentModel order) => order.userId.toString().toLowerCase());
  }
  



  void assignRemoveUser(List<UserModel> selectedUser, CartItemModel selectedOrder) async {

    try {
    statusLoader.value = true;

   final userAssigned = EmployeeOrderAssignmentModel(
      id: '',
     orderId: selectedOrder.variationId, 
     userId: selectedUser.first.id,
     fullName: selectedUser.first.firstName
     );

    
    await empOrderRepository.assigUserToCustomerOrder(userAssigned);

    // uplate the

    TLoaders.successSnackBar(title: 'Success', message: 'Order Assigned to a user');
     
   } catch (e) {
    TLoaders.warningSnackBar(title: 'Oh Snap ', message: e.toString());
    } finally {
      statusLoader.value = false;
    }


  }
 

}