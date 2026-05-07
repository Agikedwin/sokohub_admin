import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';

class GeneralBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager());
    Get.lazyPut(() => UserController());
  }
  
}