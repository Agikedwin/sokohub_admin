import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';

class TasksAssigneTable extends StatelessWidget {
  const TasksAssigneTable({super.key});

  @override
  Widget build(BuildContext context) {
    

    final controller = TasksController.instance;
    return Obx((){
      final garment = GarmentController.instance;
       final taskController = TasksController.instance; 

       // Get already assigned tasks
      if(garment.currentGarmentSelected.isNotEmpty){
     final garmentId = garment.currentGarmentSelected.last.id;
      taskController.loadSelectedGarmentTasks(garmentId);

      }
   
      return  controller.alreadySelectedGarmentTasks.isEmpty ?Center(child: Column(children: [TShimmerEffect(width: double.infinity, height: 40) ],),):
        SizedBox(
          width: double.infinity,
          child:  DataTable(
              columns: [
                 DataColumn(label: Text('Task')),
                 DataColumn(label: Text('Cost')),
                 DataColumn(label: Text('Duration')),
                DataColumn(label: Text('Action')),
              ],
              //final OrderStatus status = entry.key;
               //   final int count = entry.value;
              //   final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
              rows:  controller.alreadySelectedGarmentTasks.map((entry){
                //  final OrderStatus status = entry.key;
                //  final int count = entry.value;
                 // final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
                             
                  return DataRow(cells: [ 
                    DataCell(Text(entry.name)),
                    DataCell(Text('Ksh ${entry.cost.toString()}')),
                    DataCell(Text('${entry.duration.toString()} hrs')),
                     DataCell(TTableActionButtons(
                        onEditPressed: () => {
                          print('----------- ${entry.toJson()}')
                        },
                        onDeletePressed: () => {}
                      )),
                   // DataCell(Text(entry.toString()))
                  ]);
                             }).toList() 
            ),
          
        );
    });

    
  }
  }
