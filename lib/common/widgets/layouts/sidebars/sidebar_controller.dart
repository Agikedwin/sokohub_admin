import 'package:get/get.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class SidebarController  extends GetxController{
 // static SidebarController get instance => Get.find();

  final activeItem = ITRoutes.dashboard.obs;
  final hoverItem = ''.obs;

void changeAtiveItem(String route) => activeItem.value = route;

void changeHoverItem(String route){
  if(!isActive(route))   hoverItem.value = route;

}

bool isActive(String route) => activeItem.value == route;
bool isHovering(String route) => activeItem.value == route;

void menuOnTap (String route){

  if(!isActive(route)){

    changeAtiveItem(route);

    if(TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

    Get.toNamed((route));
  }
}

}