import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/table/customer_table_source.dart';



class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx(
      (){
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());
        return  TPaginatedDataTable(
        minWidth: 700,
        columns:  [
          DataColumn2(
            label: Text('Customer',), onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
            ),
          DataColumn2(label: Text('Email'),
         
          ),
          DataColumn2(label: Text('Phone Number'),
          ),
           DataColumn2(label: Text('Registered'),
          ),
                 
          DataColumn2(label: Text('Action'),
          fixedWidth:  100 
          ),
        ],
        source: CustomerRows(),
        
      );
      }
    );
  }
}