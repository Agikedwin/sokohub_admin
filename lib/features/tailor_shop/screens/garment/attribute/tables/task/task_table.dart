import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';

class TaskAttributeTable extends StatelessWidget {
  const TaskAttributeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TasksController.instance;
    return Obx((){
      return  controller.alreadySelectedGarmentTasks.isEmpty ?Center(child: Column(children: [TShimmerEffect(width: double.infinity, height: 40) ],),):
        SizedBox(
          width: double.infinity,
          child:  DataTable(
              columns: [
                 DataColumn(label: Text('Task Name')),
                 DataColumn(label: Text('Cost')),
                 DataColumn(label: Text('Duration')),
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
                   // DataCell(Text(entry.toString()))
                  ]);
                             }).toList() 
            ),
          
        );
    });

    
  }
  }
