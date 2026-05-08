
import 'package:get/get.dart';
import 'package:sokohub_admin/features/online_shop/models/order_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/helpers/helper_functions.dart';

class DashboardController  extends GetxController{

  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;


  /// --- Order
static final List<OrderModel> orders = [
  OrderModel(
    id: 'ORD001',
    userId: 'USR1001',
    status: OrderStatus.pending,
    totalAmount: 49.99,
    orderDate: DateTime(2026, 5, 5),
    deliveryDate: DateTime(2026, 5, 5),
  ),
  OrderModel(
    id: 'ORD002',
    userId: 'USR1002',
    status: OrderStatus.shipped,
    totalAmount: 89.50,
    orderDate: DateTime(2026, 5, 6),
    deliveryDate: DateTime(2026, 5, 6),
  ),
  OrderModel(
    id: 'ORD003',
    userId: 'USR1003',
    status: OrderStatus.delivered,
    totalAmount: 120.75,
    orderDate: DateTime(2026, 5, 4),
    deliveryDate: DateTime(2026, 5, 3),
  ),
  OrderModel(
    id: 'ORD004',
    userId: 'USR1004',
    status: OrderStatus.cancelled,
    totalAmount: 35.20,
    orderDate: DateTime(2026, 5, 7),
    deliveryDate: DateTime(2026, 5, 7),
  ),
  OrderModel(
    id: 'ORD005',
    userId: 'USR1005',
    status: OrderStatus.processing,
    totalAmount: 250.00,
    orderDate: DateTime(2026, 5, 8),
    deliveryDate: DateTime(2026, 5, 10),
  ),
  OrderModel(
    id: 'ORD006',
    userId: 'USR1006',
    status: OrderStatus.delivered,
    totalAmount: 15.99,
    orderDate: DateTime(2026, 5, 8),
    deliveryDate: DateTime(2026, 5, 2),
  ),
];

@override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();

  }

  void _calculateWeeklySales(){
    // Reset weekly sales to zero
    weeklySales.value = List<double>.filled(7, 0.0);

    for(var order in orders){
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

  for (var order in orders) {

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