import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';


class OrderRepository extends GetxController{

  final _db = FirebaseFirestore.instance;


  /// Get all orders to current user
  
  Future<List<OrderModel>> fetchUserOrders() async {
    try {

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw ' Unable to find user information. Try again in a few munutes';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((snap) => OrderModel.fromSnapshot(snap)).toList();
      
    } catch (e) {

      throw 'Someting went wrong while fetching order information. Try again later';
      
    }
  }

  // Store new user order

  Future<void> saveOrder(OrderModel order, String userId)async {
    try {
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
      
    } catch (e) {
       throw 'Someting went wrong while saving order information. Try again later';
      
    }
  }

}