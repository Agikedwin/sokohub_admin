import 'package:get/get.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/setting_controller.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';

class GeneralBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SettingController(),fenix: true);
  }
  
}