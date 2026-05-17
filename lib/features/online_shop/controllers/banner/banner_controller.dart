import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class BannerController extends GetxController {
  static BannerController get instance => Get.find();

 /*  final isLoading = false.obs;

  /// Banners
  final carousalCurrentIndex = 0.obs;

  final bannerRepository = Get.put(BannerRepository());

  RxList<BannerModel> banners = <BannerModel>[].obs;
  Rx<BannerModel> banner = BannerModel.empty().obs;
  RxList<BannerModel> maxBannerIdModel = <BannerModel>[].obs;

  // Profile Screen Controllers
  final imageName = TextEditingController();
  final imageUploading = false.obs;
  final imageUrl = ''.obs;
  var maxCategoryValue = ''.obs;
  GlobalKey<FormState> imageUploadBannerFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // ignore: strict_top_level_inference
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  /// -- Load Banners data
  Future<void> fetchBanners() async {
    try {
      /// Show loader while loading categories
      isLoading.value = true;

      /// Fetch categories from data source

      final banners = await bannerRepository.getAllBanners();

      /// Update the category list
      banners.assignAll(banners);

      /// Filtered featured banners
      final bannersList = await bannerRepository.getAllBanners();
      this.banners.assignAll(bannersList);
     } catch (e, stack) {
      print(stack);
      print(e);
      TLoaders.errorSnackBar(title: 'Oh, Snap!', message: e.toString());
    } finally {
      /// remove Loader
      //  TFullScreenLoader.stopLoading();
      isLoading.value = false;
    }

    /// -- Load selected category data
    /// Get Category or Sub-Category products
  }


  /// --- Upload Category Imabe
  Future<void> uploadBannerImage() async {
    try {
      // validate form field
      if (!imageUploadBannerFormKey.currentState!.validate()) {
        // TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Banner Name required!!');
      } else {
        //Check Internet
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(title: 'Check your internet connection');
          return;
        }

        // pick file and upload
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512,
        );
        if (image != null) {
          imageUploading.value = true;
          // start uploading image
          TFullScreenLoader.openLoadingDialog(
            'Processing',
            ITImages.docerAnimation,
          );

          final uploadedBanner = await bannerRepository.uploadImage(
            'Banners/',
            image,
          );
          imageUrl.value = uploadedBanner;
          Map<String, dynamic> newImage = {'imageUrl': uploadedBanner};
          // conver id to int and increament by 1
          //int intValue = int.parse(maxBannerId()) + 1;
          BannerModel bannerModel = BannerModel(
           // id: intValue.toString(),
            imageUrl: newImage['imageUrl'],
            active: true,
            name: imageName.text.trim(),
            targetScreen: '/seach'
          );
          await bannerRepository.saveBanner(bannerModel);
          banners.add(bannerModel);
          banners.refresh();
          //await categoryRepository.updateSingleField(newImage, '2');
          //banner.value.imageUrl = uploadedBanner;
          banner.refresh();

          imageUploading.value = false;
          //fetchBanners();
          TFullScreenLoader.stopLoading();
          TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Image successfully uploaded',
          );
        }
      }
    } catch (e) {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'OhSnap',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
      TFullScreenLoader.stopLoading();
    }
  } */
}
