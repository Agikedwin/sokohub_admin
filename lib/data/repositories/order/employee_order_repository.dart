import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/online_shop/models/employee_order_assignment_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';


class EmployeeOrderRepository extends GetxController{

  final _db = FirebaseFirestore.instance;


  /// Get all orders to current user
  
  Future<List<EmployeeOrderAssignmentModel>> getAllEmployeeAssignments() async {
    try {     

      final result = await _db.collection('EmployeeOrderTasks').get();
      return result.docs.map((snap) => EmployeeOrderAssignmentModel.fromDocSnapshot(snap)).toList();
      
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

  Future<void> addEmployeeAssignment(EmployeeOrderAssignmentModel assignment)async {
    try {
      await _db.collection('EmployeeAssignment').add(assignment.toJson());
      
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
Future<void> assigUserToCustomerOrder(EmployeeOrderAssignmentModel data) async {
  try {
    // 1. Query to see if a document with this specific UserId and OrderId already exists
    final querySnapshot = await _db
        .collection('EmployeeOrderTasks') // Replace with your actual collection name
        .where('UserId', isEqualTo: data.userId)
        .where('OrderId', isEqualTo: data.orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // 2. If it exists, REMOVE the entire document
      final existingDocId = querySnapshot.docs.first.id;
      await _db.collection('EmployeeOrderTasks').doc(existingDocId).delete();
    } else {
      // 3. If it does NOT exist, ADD the entire document
      // If data.id is empty, Firestore can auto-generate one using .doc() without arguments
      final docRef = data.id.isEmpty 
          ? _db.collection('EmployeeOrderTasks').doc() 
          : _db.collection('EmployeeOrderTasks').doc(data.id);
          
      // Update the model's internal ID if it was auto-generated before saving
      if (data.id.isEmpty) {
        data.id = docRef.id; 
      }

      await docRef.set(data.toJson());
    }

  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on SocketException catch (e) {
    throw e.message;
  } catch (e, trace) {
    print(trace);
    throw 'Something went wrong, Please try again';
  }
}

  Future<void> deleteUserAssignment(String docId) async {
    
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