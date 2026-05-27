import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/categories/category_repository.dart';
import 'package:sokohub_admin/data/repositories/order/order_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/models/employee_order_assignment_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';



class OrderController extends TBaseController<OrderModel>{

  static OrderController get instance => Get.find();

    

  final orderRepository = Get.put(OrderRepository());
  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.pending.obs;
  


  @override
  Future<List<OrderModel>> fetchItems()  async{
    sortAscending.value = false;
    return await orderRepository.getAllOrders();
  }


  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.docId.toLowerCase().contains(query.toLowerCase()) || item.totalAmount.toString().toLowerCase().contains(query.toLowerCase()) || item.status.toString().toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(OrderModel item) async{
     await orderRepository.deleteOrder(item.docId);
  }
  ///Sorting
  void sortById(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (OrderModel order) => order.totalAmount.toString().toLowerCase());
  }

   ///Sorting
  void sortByDate(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (OrderModel order) => order.orderDate.toString().toLowerCase());
  }
  

  // Update Order Status
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async{
    
   try {
    statusLoader.value = true;
    order.status = newStatus;
    
    await orderRepository.updateOrderSpecicValue(order.docId, {'status': newStatus.toString()});
    updateItemFromlist(order);
    orderStatus.value = newStatus;
    TLoaders.successSnackBar(title: 'Updated', message: 'Order Status Updated');
     
   } catch (e) {
    TLoaders.warningSnackBar(title: 'Oh Snap ', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }



}