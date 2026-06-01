import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/tables/measurement/measurement_data_table.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/widget/measuremnts_widget_popup.dart';


class MeasuremntsDetails extends StatelessWidget {
  const MeasuremntsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Measuremnts', style:  Theme.of(context).textTheme.headlineMedium,),
                MeasuremntsWidgetPopup(),

           
              ],
            ),
        
            const MeasurementAttributeTable()
        ],
      ),
    );
  }
}