import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class MeasurementAttributeTable extends StatelessWidget {
  const MeasurementAttributeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeasurementController());
    return Obx(
      (){

        return controller.alreadySelectedMeasurement.isEmpty ?Center(child: Column(children: [TShimmerEffect(width: 40, height: 40) ],),):
        SizedBox(
          width: double.infinity,
          child:
              DataTable(
              columns: [
                 DataColumn(label: Text('Name')),
                 DataColumn(label: Text('Date Registered')),
              ],
              //final OrderStatus status = entry.key;
               //   final int count = entry.value;
              //   final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
              rows:  controller.alreadySelectedMeasurement.map((entry){
                //  final OrderStatus status = entry.key;
                //  final int count = entry.value;
                 // final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
                             
                  return DataRow(cells: [
                    DataCell(
                      Row(
                        children: [
                          TCircularImage(
                            imageType: entry.image.isNotEmpty ?  ImageType.network : ImageType.asset,
                            image: entry.image.isNotEmpty ? entry.image : '',
                            height: 40,
                            width: 40,
                          ),
                          Expanded(child: Text(entry.name))
                        ],
                      )
                    ),
                    DataCell(Text(entry.formattedDate.toString())),
                   // DataCell(Text(entry.toString()))
                  ]);
                             }).toList() 
            ),
          
        );

      }
    );

    
  }
  }
