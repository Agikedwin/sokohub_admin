import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class OrderRepository extends GetxController{

  final _db = FirebaseFirestore.instance;


  /// Get all orders to current user
  
  Future<List<OrderModel>> getAllOrders() async {
    try {     

      final result = await _db.collection('Orders').orderBy('OrderDate', descending: true).get();
      return result.docs.map((snap) => OrderModel.fromSnapshot(snap)).toList();
      
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }

  }
  // Store new user order

  Future<void> addOrder(OrderModel order)async {
    try {
      await _db.collection('Orders').add(order.toJson());
      
     } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }

  }

  Future<void> updateOrderSpecicValue(String docId, Map<String, String> data) async {

 try {
      await _db.collection('Orders').doc(docId).update(data);
      
     } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }

  }

  Future<void> deleteOrder(String docId) async {
    
 try {
      await _db.collection('Orders').doc(docId).delete();
      
     } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on SocketException catch (e) {
      throw e.message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }

  }


}