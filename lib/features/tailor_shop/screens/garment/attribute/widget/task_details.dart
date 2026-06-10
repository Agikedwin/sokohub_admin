import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/tables/task/task_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/task_widget_popup.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final garmentController = GarmentController.instance;
    final garmentId = garmentController.selectedGarment.value.id;
    final controller = TasksController.instance;
    controller.loadSelectedGarmentTasks(garmentId);
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Garment Tasks', style:  Theme.of(context).textTheme.headlineMedium,),
                 TaskWidgetPopup()
              ],
            ),
        
            const TaskAttributeTable()
        ],
      ),
    );
  }
}