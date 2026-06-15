import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/task/task_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditTaskTrackingController extends GetxController  {

  static EditTaskTrackingController get instance => Get.find();

  final selectedParent = TaskModel.empty().obs;
  final isLoading = false.obs;
  final isCompleted = false.obs;
  final note = TextEditingController();
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();


  
  // Init Data
void init(TaskModel task){
  name.text = task.name.trim();
  note.text = 'some notes';
  


}
  

  // Pick thumbnail image from media


  // Register new category

  Future<void> updateTaskTracking(TaskModel task) async {


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
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

        // Map Data

       
           task.name = name.text.trim();
            task.trackingNotes = [];
           

          
           await TasksRepository.instance.updateTask(task);

           // Update Data list

          TasksController.instance.updateItemFromlist(task);
          
         

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();
        // Navigate back to the list
         Get.back();

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New record successfully added');        
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }

  } 


  // Method to reset fields
 void resetFields() {
  selectedParent(TaskModel.empty());
  isLoading(false);
  
 }

  

}