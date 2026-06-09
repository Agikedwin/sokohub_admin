import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/utils/exceptions/firebase_exceptions.dart';
import 'package:sokohub_admin/utils/exceptions/format_exceptions.dart';

class TasksRepository extends GetxController  {
  static TasksRepository get instance => Get.find();

  /// Firebase Firestore Instance
  final _db = FirebaseFirestore.instance;

  /// Get all categories from Category collection

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final snapshot = await _db.collection('Task').get();

      final result = snapshot.docs
          .map((doc) => TaskModel.fromSnapshot(doc))
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

  Future<List<TaskModel>> getAllAssignedById(
      String clientItemId) async {
    try {
      final snapshot = await _db
          .collection('Task')
          .where('ClientItemId', isEqualTo: clientItemId)
          .get();

      final result = snapshot.docs
          .map((doc) => TaskModel.fromSnapshot(doc))
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

  /// Get Sub Task
  ///
  /// Fuction to save user data to firestore

  Future<String> createTask(TaskModel empGarment) async {
    try {
      final data =
          await _db.collection('Task').add(empGarment.toJson());
      return data.id;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json, String id) async {
    try {
      await _db.collection('Task').doc(id).update(json);
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e) {
      throw 'Some thing went wrong, Please try again';
    }
  }

  /// Fuction to update user data in Firestore

  Future<TaskModel> updateTask(
      TaskModel clientOrder) async {
    print('Editing  selection ');
    print(clientOrder.toJson());
    try {
      await _db
          .collection('Task')
          .doc(clientOrder.id)
          .update(clientOrder.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Some thing went wrong, Please try again';
    }
    return TaskModel.empty();
  }

  Future<void> deleteTask(
    String employeeId,
    String clientItemId,
  ) async {
    try {
      final querySnapshot = await _db
          .collection('Task')
          .where('EmployeeId', isEqualTo: employeeId)
          .where('ClientItemId', isEqualTo: clientItemId)
          .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFormatException(e.code).message;
    } catch (e, trace) {
      print(trace);
      throw 'Something went wrong. Please try again.';
    }
  }
}
