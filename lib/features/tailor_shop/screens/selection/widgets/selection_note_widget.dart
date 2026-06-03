import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';


class SelectionNoteWidget extends StatelessWidget {
  const SelectionNoteWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           SizedBox(
            height: 300,
            child: TextFormField(
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