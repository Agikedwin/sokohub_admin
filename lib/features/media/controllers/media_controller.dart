import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/loaders/circular_loader.dart';
import 'package:sokohub_admin/data/repositories/media/media_repository.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/media/screens/widgets/media_content.dart';
import 'package:sokohub_admin/features/media/screens/widgets/media_uploader.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';
import 'package:sokohub_admin/utils/popups/dialogs.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';
import 'package:universal_html/html.dart' as html;

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;

  final int initialLoadCount = 5;
  final int loadMoreCount = 10;

  late DropzoneViewController dropzoneViewController;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxBool showImageUploaderSection = false.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductsImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandsImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUsersImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository();

  ///Get images
  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandsImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductsImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUsersImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);
      // Clear the list and new images
      targetList.assignAll(images);

      loading.value = false;
    } catch (e, trace) {
      print(e);
      print(trace);
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fetch Images, Something went wrong. try again');
    }
  }

  // Load more Images

  void loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandsImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductsImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUsersImages;
      }
     

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          initialLoadCount,
          targetList.last.createdAt ?? DateTime.now());

      // Add new images to already exixting list
      targetList.addAll(images);

      loading.value = false;
    } catch (e, trace) {
      print(e);
      print(trace);
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fetch Images, Something went wrong. try again');
    }
  }

  Future<void> selectLocalImages() async {
    final files = await dropzoneViewController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);

    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneViewController.getFileData(file);

        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select the Folder in Order to upload the Images');
      return;
    }

    TDialogs.defaultDialog(
        context: Get.context!,
        title: 'Upload Images',
        confirmText: 'Upload',
        onConfirm: () async => await uploadImages(),
        content:
            'Are you sure you want to upload all the images in ${selectedPath.value.name.toLowerCase()} folder');
  }

  Future<void> uploadImages() async {
    try {
      print('upload data');
      // remove confirmation box
      Get.back();

      //Loader
      uploadImagesLoader();

      // Get selected category
      MediaCategory selectedCategory = selectedPath.value;

      // Get corresponding list to update
      RxList<ImageModel> targetList;

      // Check the seleted category and update the corresponding list

      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;

        case MediaCategory.brands:
          targetList = allBrandsImages;
          break;

        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;

        case MediaCategory.products:
          targetList = allProductsImages;
          break;

        case MediaCategory.users:
          targetList = allUsersImages;
          break;

        default:
          return;
      }

      // Upload and add images to the target list
      // Using the reverse loop to avoid 'Concurrent modification during iteration ' error

      for (var i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;
        final Uint8List imageFile =
            await dropzoneViewController.getFileData(image);

        // Upload images to the storage

        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
          file: imageFile,
          path: getSelectedPath(),
          imageName: selectedImage.filename,
        );

        // Upload image to the firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);

        // Stop the loader
        TFullScreenLoader.stopLoading();
      }
    } catch (e, trace) {
      // Stop loading in case of error
      TFullScreenLoader.stopLoading();

      // Show warning
      TLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'Something went wrong while uploading your images');

      print(e.toString());
      print(trace.toString());
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog(
                title: const Text('Uploading Images'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      TImages.uploadingImageIllustration,
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const Text('Sit Relax, Your images are uploading...')
                  ],
                ),
              ),
            ));
  }

  String getSelectedPath() {
    switch (selectedPath.value) {
      case MediaCategory.banners:
        return TTexts.bannersStoragePath;

      case MediaCategory.brands:
        return TTexts.brandsStoragePath;

      case MediaCategory.categories:
        return TTexts.categoriesStoragePath;

      case MediaCategory.products:
        return TTexts.productsStoragePath;

      case MediaCategory.users:
        return TTexts.usersStoragePath;

      default:
        return 'Others';
    }
  }

// Popup Confirmation to remove cloud image
void removeCloudImageConfirmation(ImageModel imgae){
  // delete Confirmation
  TDialogs.defaultDialog(
    context: Get.context!,
    content: 'Are you sure you want to delete this image',
    onConfirm: () {
      // Close the previous Dialogue Image Popup
      Get.back();

      removeCloudImage(imgae);
    }
  );
}

 void removeCloudImage(ImageModel image) async {
    try {
      // Close the removeCloudImageConfirmation() Dialogue
    Get.back();

    //Show Loader
    Get.defaultDialog(
      title: '',
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      content: const PopScope(canPop: false, child: SizedBox(width: 80, height: 80, child: TCircularLoader(),),)
    );

    // Delete Image
    await mediaRepository.deleteFileFromStorage(image);

    // get the corresponding list to update
    RxList<ImageModel> targetList;

      // Check the seleted category and update the corresponding list

      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;

        case MediaCategory.brands:
          targetList = allBrandsImages;
          break;

        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;

        case MediaCategory.products:
          targetList = allProductsImages;
          break;

        case MediaCategory.users:
          targetList = allUsersImages;
          break;

        default:
          return;
      }

      // Remove from the kist
      targetList.remove(image);

      //Update list in the UI
      update();


    TFullScreenLoader.stopLoading();

    TLoaders.successSnackBar(title: 'Image Deleted', message: 'Image sucessfully deleted from cloud storage');
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImageFromMedia({
    List<String>? seletedUrls, bool allowSelection = true, 
    bool multipleSelection = false
  }) async{
    showImageUploaderSection.value  = true;
    List<ImageModel>? selectedImages = 
    await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const MediaUploader(),
                MediaContent(
                  allowSelection: allowSelection,
                 allowMultipleSelection: multipleSelection,
                  alreadySelectedUrls:   seletedUrls ?? [],
                  )
              ],
            ),
          ),
        ),
      )
    );
    return selectedImages;
  }

}
