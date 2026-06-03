import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentMeasurentsWidget extends StatelessWidget {
  const GarmentMeasurentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeasurementController());
    if (controller.allItems.isEmpty) {
      // Load measurements
      controller.fetchItems();
      // pupulate the measurements textfield  
      

    }else {
      // pupulate the measurements textfield  
    }
    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text(
            'Measuremnts',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //TypeAheadField for brand selection

          Obx(() {
            return controller.selectedMeasurement.isEmpty || controller.textFieldList.isEmpty
                ? Center(
                    child: Text('No data')
                  )
                : SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Value')),
                      ],
                      rows: List.generate(
                        controller.selectedMeasurement.length,
                        (index) {
                          final entry = controller.selectedMeasurement[index];

                          return DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    TCircularImage(
                                      imageType: entry.image.isNotEmpty
                                          ? ImageType.network
                                          : ImageType.asset,
                                      image: entry.image.isNotEmpty
                                          ? entry.image
                                          : '',
                                      height: 40,
                                      width: 40,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(entry.name),
                                    ),
                                  ],
                                ),
                              ),
                              
                              DataCell(
                                SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller:
                                        controller.valueControllers[index],
                                        keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,2}$'),
                                        ),
                                      ],
                                        
                                    decoration: const InputDecoration(
                                      hintText: 'Enter value',
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ));
          })
        ],
      ),
    );
  }
}
