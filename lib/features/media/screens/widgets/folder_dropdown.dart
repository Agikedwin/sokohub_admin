import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class MediaFilderDropdown extends StatelessWidget {
  const MediaFilderDropdown({super.key, this.onChanged});

  final void Function(MediaCategory?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final  controller  = MediaController.instance;
    return Obx(
      () => SizedBox(
        width: 140,
        child: DropdownButtonFormField(
          isExpanded: false,
          initialValue:  controller.selectedPath.value,
          items: MediaCategory.values
          .map((category) => DropdownMenuItem(
            value: category,
            child: Text(category.name.capitalize.toString()),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}