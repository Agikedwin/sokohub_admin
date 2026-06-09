import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/task/task_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class CreateTaskController extends GetxController {

  static CreateTaskController get instance => Get.find();

  final taskRepository = Get.put(TasksRepository());

  final selectedParent = TaskModel.empty().obs;
  final isLoading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final cost = TextEditingController();
  final duration = TextEditingController();
  final formKeyTask = GlobalKey<FormState>();
  



  

  // Pick thumbnail image from media


  // Register new category

  Future<void> createTask() async {


    try {
      // Start loading
      TFullScreenLoader.popUpCircular();

        //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

      // validate form field
      if (!formKeyTask.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

        // Map Data

        final newRecord = TaskModel(
          id: '',
           name: name.text.trim(), 
           duration: double.parse(duration.text.trim()) ,
           cost:  double.parse(cost.text.toString().trim()),
           createdAt: DateTime.now()
           );

          
           newRecord.id =  await TasksRepository.instance.createTask(newRecord);

           // Update Data list

           TasksController.instance.addItemTolist(newRecord);

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New task successfully added');        
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 


  // Method to reser fields
 void resetFields() {
  selectedParent(TaskModel.empty());
  isLoading(false);
  isFeatured(false);
  name.clear();
  cost.clear();
  duration.clear();
  
 }

  

}