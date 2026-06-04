import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class GarmentAccessoriesWidget extends StatelessWidget {
  const GarmentAccessoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccessoryController());
    if (controller.allItems.isEmpty) {
      // Load Accessories
      controller.fetchItems();
      // pupulate the Accessories textfield  
      

    }else {
      // pupulate the Accessories textfield  
    }
    return TRoundedContainer(
      child: Column(
        children: [
          // Accessories label

          Text(
            'Accessories',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          //TypeAheadField for brand selection

          Obx(() {
            return controller.selectedAccessory.isEmpty 
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
                        controller.allItems.length,
                        (index) {
                          final entry = controller.selectedAccessory[index];

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
                                        controller.valueControllersList[index][entry],
                                        onChanged: (value) => entry.quantity = double.tryParse(value),
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
