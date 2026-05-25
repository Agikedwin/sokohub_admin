
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class DashboardController  extends TBaseController<OrderModel>{

  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;




  @override
  Future<List<OrderModel>> fetchItems()  async{
    //feych order if empty
    if(orderController.allItems.isEmpty){
      await orderController.fetchItems();
    }

    // fetch Customers if empty
    if(customerController.allItems.isEmpty){
      await customerController.fetchItems();
    }
    // Cailculate weekly sales
    _calculateWeeklySales();

    //Calculate order status count
    _calculateOrderStatusData();

    return orderController.allItems;
  }


  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItems(OrderModel item) async{}


 

@override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();

  }

  void _calculateWeeklySales(){
    // Reset weekly sales to zero
    weeklySales.value = List<double>.filled(7, 0.0);

    for(var order in orderController.allItems){
      final DateTime orderWeeklyStart = THelperFunctions.getStartOfWeek(order.orderDate);

      // check if the order is within the current week
      if(orderWeeklyStart.isBefore(DateTime.now()) && orderWeeklyStart.add(const Duration(days: 7)).isAfter(DateTime.now())){
        int index = (order.orderDate.weekday -1) % 7;

        // Ensure the undex is not negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;

       // print('OrderDate : ${order.totalAmount}, CurrentWeekDay: $orderWeeklyStart, Index: $index');
      }
    }

   // print('Weekly Sales : $weeklySales');
  }

  void _calculateOrderStatusData() {
  // Reset status data
  orderStatusData.clear();

  // Map to store total amount for each status
  totalAmounts.value = {
    for (var status in OrderStatus.values) status: 0.0
  };

  for (var order in orderController.allItems) {

    // Convert String to OrderStatus
    final status = order.status ;
    // Count orders
    orderStatusData[status!] =
        (orderStatusData[status] ?? 0) + 1;

    // Calculate total amount for each order
    totalAmounts[status] =
        (totalAmounts[status] ?? 0) + order.totalAmount;
  }
}


String getOrderStatusName(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'Pending';

    case OrderStatus.processing:
      return 'Processing';

    case OrderStatus.shipped:
      return 'Shipped';

    case OrderStatus.delivered:
      return 'Delivered';

    case OrderStatus.cancelled:
      return 'Cancelled';

    default:
      return 'Unknown';
  }
}


}