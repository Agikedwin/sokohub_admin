import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class ITTableHeader extends StatelessWidget {
  const ITTableHeader({
    super.key, this.onPressed, 
  required this.buttonText, 
  this.searchController,
   this.searchOnChanged, 
   this.showLeftWidget = true,
   });

  final Function()? onPressed;
  final String buttonText;
  final TextEditingController? searchController;
  final Function(String)? searchOnChanged;
  final bool  showLeftWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: !TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
            child: showLeftWidget ? Row(
              children: [
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: onPressed,
                        child:  Text(buttonText))),
              ],
            ) : SizedBox.shrink()) ,
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: const InputDecoration(
              hintText: 'Search here ...',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
        )
      ],
    );
  }
}
