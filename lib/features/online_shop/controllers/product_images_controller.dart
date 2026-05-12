import 'package:get/get.dart';
import 'package:sokohub_admin/features/media/controllers/media_controller.dart';
import 'package:sokohub_admin/features/media/models/image_model.dart';

class ProductImagesController  extends GetxController{
  static ProductImagesController get instance => Get.find();

  //Rx Observables for the selected thumnails image
  final Rx<String?> selectedThumnailImage = Rx<String?>(null);

   //List to store additional products
  final RxList<String> addtionalProductImagesUrl = <String>[].obs;

  /// Pick thumnail image from the media
 void selectThumnailImage() async{
  final  controller = Get.put(MediaController());
  List<ImageModel>? selectedImages =  await controller.selectImageFromMedia();

    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      // Set the selected image to the main image or perform any other actions
      ImageModel selectedImage = selectedImages.first;

      // Update the main image using the selectedImage
      selectedThumnailImage.value = selectedImage.url;
    }
  }

  /// Pick multple images from the media
   void selectMultipeProductImages() async{
    final  controller = Get.put(MediaController());
    final selectedImages =  await controller.selectImageFromMedia(multipleSelection: true, seletedUrls: addtionalProductImagesUrl);

    // Handle the selected images
    if(selectedImages != null && selectedImages.isNotEmpty){
      addtionalProductImagesUrl.assignAll(selectedImages.map((e) => e.url,));
    }

  }
  
  /// Function to remove Product image
  Future<void> removeImage(int index) async{
    addtionalProductImagesUrl.removeAt(index);

  }

}