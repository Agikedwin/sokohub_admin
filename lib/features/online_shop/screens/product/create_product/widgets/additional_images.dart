import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/image_uploader.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({super.key, required this.additionalProductImagesURLs, required this.onTapToAddImages, required this.onTapToRemoveImages});

  final RxList<String> additionalProductImagesURLs;
  final void Function() onTapToAddImages;
  final void Function(int index) onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    print('==============333');
    print(additionalProductImagesURLs);
    return SizedBox(
        height: 300,
        child: Column(
          children: [

            // Section to add additional product images

            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTapToAddImages,
                child: TRoundedContainer(
                  child: Obx(
                   () => Center(
                      child: additionalProductImagesURLs.isEmpty ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(TImages.defaultMultiImageIcon, width: 50, height: 50,),
                          const Text('Add Additional Product Images')
                        ],
                      ): Column(
                        mainAxisSize: MainAxisSize.min ,
                        children: [
                          TRoundedImage(
                              width: 100,
                               height: 100,
                                image: additionalProductImagesURLs.first,
                                 imageType: ImageType.network
                                 ),
                                 const Text('Add Additional Product Images')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Section to display uploaded Images
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(height: 80, 
                    child: Obx(
                      () => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: additionalProductImagesURLs.length,
                          separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2,), 
                          itemBuilder: (context, index){
                            final image = additionalProductImagesURLs[index];
                            return TImageUploader(
                              top: 0,
                              right: 0,
                              width: 80,
                              height: 80,
                              left: null,
                              bottom: null,
                              image: image,
                              icon: Iconsax.trash,
                              imageType: ImageType.network,
                              onIconButtonPressed: () => onTapToRemoveImages(index),
                      
                            );
                          },
                          
                          
                          ),
                    ),
                    
                    ),
                    
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems /2,),

                  // Add More Images button
                  TRoundedContainer(
                    width: 80,
                    height: 80,
                    showBorder: true,
                    backgroundColor: TColors.white,
                    borderColor: TColors.grey,
                    onTap: onTapToAddImages,
                    child: const Center(child: Icon(Iconsax.add),),
                  )
                ],
              ),
            )

          ],
        ),
      
    );
  }
  Widget? _uploadImafesOrEmptyList() {
    print('========================');
    print(additionalProductImagesURLs);
  return additionalProductImagesURLs.isNotEmpty ? _uploadImages() : emptyList();
 // return emptyList();
}

// Widget to display Empty List Placeholder
Widget emptyList(){
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => const TRoundedContainer(backgroundColor: TColors.primaryBackground, width: 80, height: 80,),
     separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2,), 
     itemCount: 6
     );
}

ListView _uploadImages(){
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: additionalProductImagesURLs.length,
    separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems / 2,), 
    itemBuilder: (context, index){
      final image = additionalProductImagesURLs[index];
      return TImageUploader(
        top: 0,
        right: 0,
        width: 80,
        height: 80,
        left: null,
        bottom: null,
        image: image,
        icon: Iconsax.trash,
        imageType: ImageType.network,
        onIconButtonPressed: () => onTapToRemoveImages(index),

      );
    },
    
     
     );
}
}

