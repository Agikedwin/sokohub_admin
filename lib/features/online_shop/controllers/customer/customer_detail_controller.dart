import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/data/repositories/address/address_repository.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading  = true.obs;
  RxBool addressLoading  = true.obs;
  RxInt sortColumnIndex  = 1.obs;
  RxBool sortAscending  = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;


  /// -- Load cutomer orders
  
  Future<void> getCustomerOrders() async {
    try {
      //Show loader loading cateries
      print('---------------------------');

      ordersLoading.value = true;
      print(customer.value.toJson());

      // Fetch custmer orders and addresses
      if(customer.value.id != null && customer.value.id.isNotEmpty){
        customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id);
      }
       print('--------------------------22-');
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      filteredCustomerOrders.assignAll(customer.value.orders ?? []);
     print('---------------------------33');
      // Add all rows as false [Not selected ] & Toggle when  required
      selectedRows.assignAll(List.generate(customer.value.orders != null ? customer.value.orders!.length : 0, (index) => false));
      
    } catch (e, trace) {
      print(e);
      print(trace);
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      ordersLoading.value = false;
    }
  }

  // Load customer orders
  Future<void> getCustomersAddress() async {
    try {
      // Show loader while loading 
      addressLoading.value = true;

      // Fetch customers and Addresess
        if(customer.value.id != null && customer.value.id.isNotEmpty){
        customer.value.addresses = await addressRepository.fetchUserAddress(customer.value.id!);
      }
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      addressLoading.value = false;
    }
  }
  
   // Search Query
  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where((customer) => customer.id.toLowerCase().contains(query.toLowerCase()) || customer.orderDate.toString().contains(query.toLowerCase()))
    );

    update();
    
  }

  /// Common method for sorting items by a property
  void sortById(int sortColumnIndex, bool ascending) {

     sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
   
    filteredCustomerOrders.sort((a,b){
      if(ascending){
        return a.id.toLowerCase().compareTo(b.id);
      }else{
        return b.id.toLowerCase().compareTo(a.id);
      }
    });
    update();
  }
}