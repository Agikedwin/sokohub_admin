import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/tables/accessory/accessory_table_source.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class AccessoryAttributeTable extends StatelessWidget {
  const AccessoryAttributeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccessoryController());
    return Obx((){
      return  controller.alreadySelectedAccessory.isEmpty ?Center(child: Column(children: [TShimmerEffect(width: 40, height: 40) ],),):
        SizedBox(
          width: double.infinity,
          child:  DataTable(
              columns: [
                 DataColumn(label: Text('Name')),
                 DataColumn(label: Text('Unit Cost')),
              ],
              //final OrderStatus status = entry.key;
               //   final int count = entry.value;
              //   final totalamount = (controller.totalAmounts[status] ?? 0.0).toStringAsFixed(2);
              rows:  controller.alreadySelectedAccessory.map((entry){
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
                    DataCell(Text('Ksh ${entry.unitCost.toString()}')),
                   // DataCell(Text(entry.toString()))
                  ]);
                             }).toList() 
            ),
          
        );
    });

    
  }
  }
