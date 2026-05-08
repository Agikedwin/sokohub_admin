import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class MediaController  extends GetxController{
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneViewController;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxBool showImageUploaderSection = false.obs;
}