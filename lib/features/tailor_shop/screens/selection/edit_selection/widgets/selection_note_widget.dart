import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/create_client_selection_order_controller.dart';


class SelectionNoteWidget extends StatelessWidget {
  const SelectionNoteWidget({super.key, this.note});

  final String? note;
  

  @override
  Widget build(BuildContext context) {
    final controller = CreateClientSelectionOrderController.instance;
    controller.description.text = note!;
    return TRoundedContainer(
      child: Form( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           SizedBox(
            height: 300,
            child: TextFormField(
              controller:  controller.description,
              expands: true,
              maxLines: null,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                labelText: 'Item Note',
                hintText: 'Add your item description here ...',
                alignLabelWithHint: true
              ),
            ),
           )
          ],
        ),
      ),
    );
  }
}