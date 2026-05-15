import 'package:get/get.dart';
class HomeController extends GetxController {

  static HomeController get instance => Get.find();

/// Banners
  final carousalCurrentIndex = 0.obs;

  // ignore: strict_top_level_inference
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }
}