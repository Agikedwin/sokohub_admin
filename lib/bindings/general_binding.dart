import 'package:get/get.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/setting_controller.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/client_garment_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/create_client_selection_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/edit_client_selection_order_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/selection/garment_selection_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/employee_garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:web/web.dart';

class GeneralBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SettingController(),fenix: true);
    Get.lazyPut(() => GarmentController(),fenix: true);
    Get.lazyPut(() => CustomerController(),fenix: true);
    Get.lazyPut(() => OrderController(),fenix: true);
    Get.lazyPut(() => MaterialController(),fenix: true);
    Get.lazyPut(() => MeasurementController(),fenix: true);
    Get.lazyPut(() => AccessoryController(),fenix: true);
    Get.lazyPut(() => CreateClientSelectionOrderController(),fenix: true);
    Get.lazyPut(() => EditClientSelectionOrderController(),fenix: true);  
    Get.lazyPut(() => GarmentSelectionController(),fenix: true); 
    Get.lazyPut(() => ClientGarmentOrderController(),fenix: true); 
    Get.lazyPut(() => EmployeeGarmentController(),fenix: true);
    Get.lazyPut(() => TasksController(),fenix: true); 
     
  }
  
}