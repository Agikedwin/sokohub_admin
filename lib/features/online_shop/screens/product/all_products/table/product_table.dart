import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/product_controller.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/table/table_source.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';


class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(ProductController());
    return Obx(
      () {
        // Products and selected rows are hidden => just to update UI => OBx [ProductModel]
        Visibility(visible: false, child: Text(controller.filteredItems.length.toString()));
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()));

        //Table
       return TPaginatedDataTable(
        minWidth: 1000,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns:  [
          DataColumn2(
            label: Text('Product',),
            fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
            onSort: (sortColumnIndex, ascending) => controller.sortByName(sortColumnIndex, ascending),
            ),
          DataColumn2(label: Text('Stock'),
          onSort: (sortColumnIndex, ascending) => controller.sortByName(sortColumnIndex, ascending),
          ),
          DataColumn2(label: Text('Sold'),
          onSort: (sortColumnIndex, ascending) => controller.sortByName(sortColumnIndex, ascending),
          ),
          DataColumn2(label: Text('Brand'),
          ),
           DataColumn2(label: Text('Price'),
           onSort: (sortColumnIndex, ascending) => controller.sortByName(sortColumnIndex, ascending),
          ),
           DataColumn2(label: Text('Date'),
          ),
          
          DataColumn2(label: Text('Action'),
          fixedWidth:  100 
          ),
        ],
        source: ProductRows(),
        
      );
      }
    );
  }
}