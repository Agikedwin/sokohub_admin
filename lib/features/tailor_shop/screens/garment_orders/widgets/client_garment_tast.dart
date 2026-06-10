import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/widgets/table/task/tasks_assigne_table.dart';

class ClientGarmentTast extends StatelessWidget {
  const ClientGarmentTast({super.key});

  @override
  Widget build(BuildContext context) {
    
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tasks', style:  Theme.of(context).textTheme.headlineMedium,),
              ],
            ),
        
            const TasksAssigneTable()
        ],
      ),
    );
  }
}