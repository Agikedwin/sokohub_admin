import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/tables/accessory/accessory_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/accessory_widget_popup.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class AccessoryDetails extends StatelessWidget {
  const AccessoryDetails({super.key});

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
                Text('Accessories', style:  Theme.of(context).textTheme.headlineMedium,),
                 AccessoryWidgetPopup()
              ],
            ),
        
            const AccessoryAttributeTable()
        ],
      ),
    );
  }
}