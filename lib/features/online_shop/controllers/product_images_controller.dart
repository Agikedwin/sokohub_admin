import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_variation_model.dart';

class ProductImagesController  extends GetxController{
  static ProductImagesController get instance => Get.find();

  //Rx Observables for the selected thumnails image
  final Rx<String?> selectedThumnailImageUrl = Rx<String?>(null);

   //List to store additional products
  final RxList<String> addtionalProductImagesUrl = <String>[].obs;

  // Fuction to remove Product Image
  Future<void> removeImage(int index) async{
    addtionalProductImagesUrl.removeAt(index);

  }

  /// Pick thumnail image from the media
 void selectThumnailImage() async{
  final  controller = Get.put(MediaController());
  List<ImageModel>? selectedImages =  await controller.selectImageFromMedia();

    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other actions
      ImageModel selectedImage = selectedImages.first;

      // Update the main image using the selectedImage
      selectedThumnailImageUrl.value = selectedImage.url;
    }
  }

  /// Pick Variation image from the media
 void selectVariationImage(ProductVariationModel variation) async{
  final  controller = Get.put(MediaController());
  List<ImageModel>? selectedImages =  await controller.selectImageFromMedia();


    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other actions
      ImageModel selectedImage = selectedImages.first;

      // Update the main image using the selectedImage
      variation.image.value = selectedImage.url;

      
    }
  }

  /// Pick multple images from the Gallary
   void selectMultipeProductImages() async{
    final  controller = Get.put(MediaController());
    final selectedImages =  await controller.selectImageFromMedia(multipleSelection: true, seletedUrls: addtionalProductImagesUrl);

   
    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      addtionalProductImagesUrl.assignAll(selectedImages.map((e) => e.url,));
    }

    


  }
  



}