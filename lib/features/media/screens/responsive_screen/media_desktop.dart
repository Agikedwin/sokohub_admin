import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/screens/widgets/media_content.dart';
import 'package:sokohub_admin/features/media/screens/widgets/media_uploader.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  TBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [
                      ITRoutes.login,
                      'some test'
                    ],
                    returnToPreviousScreen: false,
                  ),

                  // Toggle Images Section Button
                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showImageUploaderSection.value = ! controller.showImageUploaderSection.value,
                      icon: const Icon(Iconsax.cloud_add),
                      label: const Text('Upload Images'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Upload Area
              MediaUploader(),

               SizedBox(height: TSizes.spaceBtwSections,),


              /// Media
              MediaContent()
              
            ],
          ),
        ),
      ),
    );
  }
}
