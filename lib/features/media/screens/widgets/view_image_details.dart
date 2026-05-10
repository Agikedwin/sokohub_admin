import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class ImagePopup extends StatelessWidget {
  const ImagePopup({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return SingleChildScrollView(     
      
      child: Dialog(
         // define shppe of the dialogue
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
         child: TRoundedContainer(
          // set the wid of the roundeded container based on the screen sice
          width: TDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child:   Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option close to the dialogue

              SizedBox(
                child: Stack(
                  children: [
                    // Display image with the rounded container
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        image: image.url,
                        applyImageRadius: true,
                        height: MediaQuery.of(context).size.height * 0.4 ,
                        width:  TDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width * 0.4 : double.infinity,
                        imageType: ImageType.network,

                      ),
                    ),
                    
                    // close icon button positioned at the top-right corner
                    Positioned( top: 0, right: 0, child: IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.close_circle)),)
                  ],
                ),
              ),
              // Display various metadata about the image
              // Also provide an optional copy the image URL
              Row(
                children: [
                  Expanded(child: Text('Image Name', style: Theme.of(context).textTheme.bodyLarge,)),
                   Expanded(flex: 3, child: Text(image.filename, style: Theme.of(context).textTheme.titleLarge,)),

                ],
              ),

              // Display Image URL with the option to copy
              Row(
                children: [
                   Expanded(child: Text('Image URL', style: Theme.of(context).textTheme.bodyLarge,)),
                   Expanded(flex: 2, child: Text(image.url, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis,)),

                   Expanded(
                    child: OutlinedButton(
                      onPressed: (){
                        FlutterClipboard.copy(image.url).then((value) => TLoaders.customToast(message: 'URL copied'));
                      },
                       child: const Text('Copy URL')
                       ),
                   ),
              
                   const SizedBox(height: TSizes.spaceBtwSections,),                 

                ],

              ),
              // Display a button to delete the image
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: TextButton(onPressed: ()=> controller.removeCloudImageConfirmation(image), child: const Text('Delete Image', style: TextStyle(color: Colors.red),)),
                      )
                    ],
                   )
            ],
          ),
         ),
        
      ),
    );
  }
}