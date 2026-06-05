import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';

class CustomerController  extends TBaseController<UserModel>{

static CustomerController get instance => Get.find();

final customerRepository = Get.put(UserRepository());

RxList<UserModel> allCustomers = <UserModel>[].obs;

TextEditingController selectedTextController = TextEditingController();
Rx<UserModel> selectedClient = UserModel.empty().obs;


@override
  Future<List<UserModel>> fetchItems() async{
    
    final data = await customerRepository.getAllUsers();
    allCustomers.assignAll(data);
    return data;
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(UserModel item) async{

    await customerRepository.deleteUser(item.id);
  }
  



  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (UserModel category) => category.firstName.toLowerCase());
  }
  

  
}