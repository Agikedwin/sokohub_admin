import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/screens/widgets/folder_dropdown.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImageUploaderSection.value ? Column(
        children: [
          /// Drag and drop Area
          TRoundedContainer(
            height: 250,
            showBorder: true,
            borderColor: TColors.borderPrimary,
            backgroundColor: TColors.primaryBackground,
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DropzoneView(
                        mime: const ['image/jpeg', 'image/png'],
                        cursor: CursorType.Default,
                        operation: DragOperation.copy,
                        onLoaded: () => print('Zone Loaded'),
                        onError: (ev) => print('Zone  error: $ev '),
                        onHover: () => print('Zone hover'),
                        onLeave: () => print('Zone left'),
                        onCreated: (ctrl) =>
                            controller.dropzoneViewController = ctrl,
                        onDropFile: (file) {},
                        onDropInvalid: (er) => print('Zone invalid MINE : $er'),
                        onDropFiles: (ev) async {
                          print('Zone drop multiple: $ev');
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            TImages.defaultMultiImageIcon,
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Text('Drag and Drop Images here'),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          OutlinedButton(
                              onPressed: () {},
                              child: const Text('Select Images'))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
      
          /// Locally Selected Images
      
          TRoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Folder dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Folder Dropdown
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
                            }
                          },
                        )
                      ],
                    ),
                    /// Upload and remove buttons
                    Row(
                      children: [
                        TextButton(onPressed: (){}, child: Text('Remove All')),
                         const SizedBox(height: TSizes.spaceBtwItems,),
                         TDeviceUtils.isMobileScreen(context) 
                         ? const SizedBox.shrink()
                         : SizedBox(width: TSizes.buttonWidth, child: ElevatedButton(onPressed: (){}, child: Text('Upload'))),
                      ],
                    ),
                    
      
                    
                    
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),
                Wrap(
                      alignment: WrapAlignment.start,
                      spacing:  TSizes.spaceBtwItems / 2,
                      runSpacing: TSizes.spaceBtwItems / 2,
                      children: [
                        TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                         TRoundedImage(
                          width: 90,
                          height: 90,
                          padding: TSizes.sm,
                          imageType: ImageType.asset,
                          image: TImages.darkAppLogo,
                          //memoryImage: Element.lo,
                          backgroundColor: TColors.primaryBackground,
                        ),
                        
      
                      ],
                    ),
      
                    const SizedBox(height: TSizes.spaceBtwSections,),
                         TDeviceUtils.isMobileScreen(context) 
                         ? SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text('Upload')))
                         :  const SizedBox.shrink()
              ],
            ),
          )
        ],
      ) : 
      SizedBox.shrink(),
      
    );
  }
}
