import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';

class ClientSelectionOrderRepository extends GetxController {
  static ClientSelectionOrderRepository get instance => Get.find();

  /// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all categories from Category collection

  Future<List<ClientSelectionAttributesModel>>
      getAllClientSelectionOrder() async {
    try {
      final snapshot = await _db.collection('ClientSelectionOrder').get();

      final result = snapshot.docs
          .map((doc) => ClientSelectionAttributesModel.fromSnapshot(doc))
          .toList();

      return result;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(e);
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Get Sub ClientSelectionOrder
  ///
  /// Fuction to save user data to firestore

  Future<String> createClientSelectionOrder(
      ClientSelectionAttributesModel clientOrder) async {
    try {
      final data = await _db
          .collection('ClientSelectionOrder')
          .add(clientOrder.toJson());
      return data.id;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      print(e);

      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json, String id) async {
    try {
      await _db.collection('ClientSelectionOrder').doc(id).update(json);
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Fuction to update user data in Firestore
  Future<ClientSelectionAttributesModel> updateClientSelectionOrder(
    ClientSelectionAttributesModel clientOrder,
  ) async {
    print('Editing selection');

    final data = clientOrder.toJson();

    print('--- FIRESTORE PAYLOAD START ---');
    print(data);
    print('--- FIRESTORE PAYLOAD END ---');

    try {
      await _db
          .collection('ClientSelectionOrder')
          .doc(clientOrder.id)
          .update(data);
    } on FirebaseException catch (e, stackTrace) {
      print('🔥 FIREBASE ERROR: ${e.code}');
      print('🔥 FIREBASE MESSAGE: ${e.message}');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    } on PlatformException catch (e, stackTrace) {
      print('🔥 PLATFORM ERROR: ${e.code}');
      print('🔥 MESSAGE: ${e.message}');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      print('🔥 UNKNOWN ERROR: $e');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    }

    return ClientSelectionAttributesModel.empty();
  }

  Future<void> deleteClientSelectionOrder(String clientOrderId) async {
    try {
      await _db.collection('ClientSelectionOrder').doc(clientOrderId).delete();
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> updateGarmentTaskById({
    required String docId,
    required List<TaskModel> tasks,
    required TaskModel updatedTask,
  }) async {
    try {
      final taskExists = tasks.any((task) => task.id == updatedTask.id);

      if (!taskExists) {
        throw Exception(
          'Task with id ${updatedTask.id} not found',
        );
      }

      final updatedTasks = tasks.map((task) {
        return task.id == updatedTask.id ? updatedTask : task;
      }).toList();

      final garmentTasksJson = updatedTasks.map((e) => e.toJson()).toList();

      // Debug the exact payload being sent
     

      await _db.collection('ClientSelectionOrder').doc(docId).update({
        'GarmentTasks': garmentTasksJson,
      });

      print('✅ Task updated successfully');
    } on FirebaseException catch (e, stackTrace) {
      print('🔥 FIREBASE ERROR: ${e.code}');
      print('🔥 FIREBASE MESSAGE: ${e.message}');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    } on PlatformException catch (e, stackTrace) {
      print('🔥 PLATFORM ERROR: ${e.code}');
      print('🔥 MESSAGE: ${e.message}');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      print('🔥 UNKNOWN ERROR: $e');
      print('🔥 STACK TRACE: $stackTrace');
      rethrow;
    }
  }
}
