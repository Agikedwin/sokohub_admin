import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product_images_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductThumbnailImageWidget extends StatelessWidget {
  const ProductThumbnailImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductImagesController controller = Get.put(ProductImagesController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Product Thumbnail Text
          Text('Product Thumbnail', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          // Container for product thumbnail
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image

                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => TRoundedImage(
                            width: 220,
                             height: 220,
                              image: controller.selectedThumnailImageUrl.value ?? TImages.defaultSingleImageIcon,
                               imageType: controller.selectedThumnailImageUrl.value == null ?  ImageType.asset : ImageType.network
                               ),
                        ),
                      )
                    ],
                  ),

                  // Add Thumbnail button

                  SizedBox(width: 200, child: OutlinedButton(onPressed: () => controller.selectThumnailImage(), child: const Text('Add Thumbnail')),)

                ],
              ),
            ),
          )

        ],
        
      ),
    );
  }
}