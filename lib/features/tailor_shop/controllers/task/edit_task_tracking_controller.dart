import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/employee_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/tracking_notes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/selection/client_selection_order_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditTaskTrackingController extends GetxController  {

  static EditTaskTrackingController get instance => Get.find();

  final clientSelectionOrderRepository = Get.put(ClientSelectionOrderRepository());

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
        
        final trackingNotes = task.trackingNotes;
       // trackingNotes!.add(TrackingNoteModel(note: 'some notes', createdAt: DateTime.now()));
            task.trackingNotes = trackingNotes;
            task.status = isCompleted.value ? 'Completed' : 'Pending';
            task.completedAt =DateTime.now();
            task.doneBy = EmployeeGarmentController.instance.selectedEmployees;

           
        // Get the selected ClientSelectionAttributesModel from the arguments
        final tasks = GarmentSelectionController.instance.selectedGarmentSelection.value.garmentTasks;
        final docId = GarmentSelectionController.instance.selectedGarmentSelection.value.id;
         
           

          
          await clientSelectionOrderRepository.updateGarmentTaskById(docId: docId, tasks: tasks!, updatedTask: task);

          tasks.map((task) {
            return task.id == task.id ? task : task;
          }).toList();


           // Update Data data
           GarmentSelectionController.instance.selectedGarmentSelection.value.garmentTasks = tasks;

           // Add to the selected collection

          //TasksController.instance.updateItemFromlist(task);
          
         

           resetFields();

           // Remove Loader
        TFullScreenLoader.stopLoading();
        // Navigate back to the list
         Get.back();

         // Back to the selection page
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