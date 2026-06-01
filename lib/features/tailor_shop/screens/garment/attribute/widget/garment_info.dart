import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class GarmentInfo extends StatelessWidget {
  const GarmentInfo({super.key, required this.garment});

  final GarmentModel garment;

  @override
  Widget build(BuildContext context) {
    final garmentController = GarmentController.instance;
    garmentController.selectedGarment.value = garment;
    final accessController = Get.put(AccessoryController());
    accessController.loadSelectedAccessories(garment.id);

    final measuremntController = Get.put(MeasurementController());
    measuremntController.loadSelectedMeasuremnts(garment.id);
    return  TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text('Garment ', style:  Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: TSizes.spaceBtwSections ,),
          // meta data

          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                     TRoundedImage(
                      imageType: garment.image.isNotEmpty ? ImageType.network : ImageType.asset, 
                      image: garment.image.isNotEmpty ? garment.image : TImages.productImage10,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Garment Name', style: Theme.of(context).textTheme.labelMedium,),
                      Text('${garment.name.toString().capitalize}', style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    )
                  ],
                ),
              ),

               Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date ', style: Theme.of(context).textTheme.labelMedium,),
                      Text(garment.formattedDate, style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Unit Cost', style: Theme.of(context).textTheme.labelMedium,),
                      Text('\Ksh ${garment.wage.toString()}' , style: Theme.of(context).textTheme.titleLarge,),

                        ],
                      ),
                    )
            ],
          )


            ],
          )

        
      );
    
  }
}