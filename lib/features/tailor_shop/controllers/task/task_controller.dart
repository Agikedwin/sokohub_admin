import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/task_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/task/task_repository.dart';

class TasksController  extends TBaseController<TaskModel>{

  static  TasksController get instance => Get.find();

  final taskRepository = Get.put(TasksRepository());
  

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
  
}