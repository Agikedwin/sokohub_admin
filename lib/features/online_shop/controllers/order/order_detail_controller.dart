import 'package:get/get.dart';
import 'package:sokohub_admin/data/repositories/user/user_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class OrderDetailController extends GetxController{
  static OrderDetailController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  RxBool isloading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  /// Load customers orders
  
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      // Show Loader while loading Orders

      // Fetch customers and addresses
      final user = await userRepository.fetchUserDetail(order.value.userId);
     

      customer.value = user;
      
    } catch (e, trace) {
      print(trace);
    } finally {
      isloading.value = false;
    }
  }
}