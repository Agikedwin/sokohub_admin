import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';

class CustomerController  extends TBaseController<UserModel>{

static CustomerController get instance => Get.find();

final customerRepository = Get.put(UserRepository());


@override
  Future<List<UserModel>> fetchItems() async{
    return await customerRepository.getAllUsers();
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