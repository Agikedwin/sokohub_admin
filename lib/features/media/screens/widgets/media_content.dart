import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/common/widgets/loaders/animation_loader.dart';
import 'package:sokohub_admin/common/widgets/loaders/loader_animation.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/media/screens/widgets/folder_dropdown.dart';
import 'package:sokohub_admin/features/media/screens/widgets/view_image_details.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Meadia images header
                    Row(
                      children: [
                        Text('Select Folder',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        MediaFilderDropdown(
                          onChanged: (MediaCategory? newValue) {
                            if (newValue != null) {
                              controller.selectedPath.value = newValue;
                              controller.getMediaImages();
                            }
                          },
                        )
                      ],
                    ),
          SizedBox(height: TSizes.spaceBtwSections,),


          // Show Media
          Obx(
           () {
            // Get selected folder images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            // Loader
            if(controller.loading.value && images.isEmpty) return const TLoaderAnimation();

            // Empty Widget
            if(images.isEmpty) return _buildEmptyAnimationWidget(context);

            return  Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                            alignment: WrapAlignment.start,
                            spacing:  TSizes.spaceBtwItems / 2,
                            runSpacing: TSizes.spaceBtwItems / 2,
                            children: images.
                            map((image) => GestureDetector(
                              onTap: () => Get.dialog(ImagePopup(image: image,)),
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    buildSimpleList(image),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                                        child: Text(image.filename, maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      ),
                                    )
                                  ],
                                  
                                ),
                              ),
                            )).toList(),
                          ),
            
            
                      /// Load More Media Button
                      if(!controller.loading.value)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: TSizes.buttonWidth,
                              child: ElevatedButton.icon(
                                onPressed: () => controller.loadMoreMediaImages(), 
                              label: const Text('Load More'),
                               icon: Icon(Iconsax.arrow_down),),
                            )
                          ],
                        ),
                      )
              ],
            );
           }
          ),
        ],
      ),
    );
  }


List<ImageModel> _getSelectedFolderImages(MediaController controller) {
  List<ImageModel> images = [];

  if(controller.selectedPath.value == MediaCategory.banners){
    images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
  } else if(controller.selectedPath.value == MediaCategory.brands){
    images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
  }else if(controller.selectedPath.value == MediaCategory.categories){
    images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
  }else if(controller.selectedPath.value == MediaCategory.products){
    images = controller.allProductsImages.where((image) => image.url.isNotEmpty).toList();
  }else if(controller.selectedPath.value == MediaCategory.users){
    images = controller.allUsersImages.where((image) => image.url.isNotEmpty).toList();
  }
  return images;
}
  
  Widget _buildEmptyAnimationWidget(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        animation: TImages.packageAnimation,
        text: 'Select Your Desired Folder',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
  
  buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      imageType: ImageType.network,
      image: image.url,      
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }


}
