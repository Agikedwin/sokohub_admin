import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_tasks_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/task/task_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class TasksController  extends TBaseController<TaskModel>{

  static  TasksController get instance => Get.find();

  final taskRepository = Get.put(TasksRepository());

  RxBool tasksLoading = false.obs;
  RxList<TaskModel> alreadySelectedGarmentTasks = <TaskModel>[].obs;
  RxList<TaskModel> selectedTasks = <TaskModel>[].obs;
  

  @override
  bool containsSearchQuery(TaskModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(TaskModel item) async{
    await taskRepository.deleteTask(item.id!, '');
  }
  
  @override
  Future<List<TaskModel>> fetchItems()  async{
    return await taskRepository.getAllTasks();
  }
  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (TaskModel material) => material.name.toLowerCase());
  }

  void assignSelectedTasks( List<TaskModel> data){
   
  //  selectedAccessory.assignAll(data);
  } 

  Future<List<TaskModel>> loadSelectedGarmentTasks(
      String garmentId) async {
    tasksLoading.value = true;

    // Product tasksLoading
    final garmentTask =
        await taskRepository.getGarmentTasksById(garmentId);

    if (allItems.isEmpty) await fetchItems();

    final taskIds =
        garmentTask.map((e) => e.taskId).toList();

    final garmentTasks = allItems
        .where((element) => taskIds.contains(element.id))
        .toList();

    alreadySelectedGarmentTasks.assignAll(garmentTasks);
    tasksLoading.value = false;

    return garmentTasks;
  }


  Future<void> addGarmentTask(List<TaskModel>  selectedTasks) async{
    try {
       TFullScreenLoader.popUpCircular();

        //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }
      // Save all selected Tasks

   

      //Register  Garment Tasks  if any
      if (selectedTasks.isNotEmpty) {
        // Loop through selected Garment Tasks
        tasksLoading.value = true;

      // Get existing Task Ids
      List<String?> existingTaskIds = alreadySelectedGarmentTasks.map((task) => task.id).toList();

      for (var task in selectedTasks) {
        
        // Check if the Task is not already associated with the garment
        if(!existingTaskIds.contains(task.id)){
          // Map Data
         final garmentTask = GarmentTasksModel(
          id: '', 
          garmentId: GarmentController.instance.selectedGarment.value.id,
           taskId: task.id!
           );

           // Save the selected Task
          
           await  taskRepository.createGarmentTask(garmentTask);

           alreadySelectedGarmentTasks.add(selectedTasks.firstWhere((item) => item.id == task.id));
           
          
        }
        
      }

      // Remove Tasks not selected by the user
      for (var existingTaskId in existingTaskIds) {
        // Check if the Task is not already associated with the Garment
        if(!selectedTasks.any((task) => task.id == existingTaskId)){
          // Remove the association
          await  taskRepository.deleteGarmentTask(existingTaskId!, GarmentController.instance.selectedGarment.value.id);

          alreadySelectedGarmentTasks.removeWhere((item) => item.id == existingTaskId);
        }
        
      }

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New record successfully added'); 
         alreadySelectedGarmentTasks.refresh(); 
      }
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally{
      TFullScreenLoader.stopLoading();
    }

  }

 
  
}