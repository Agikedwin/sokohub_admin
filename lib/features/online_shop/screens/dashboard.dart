import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/data_table/paginated_data_table.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController1 controller = Get.put(DashboardController1());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextFormField(
                controller: controller.searchTextController,
                onChanged: (query) => controller.searchQuery(query) ,
                decoration: const InputDecoration(hintText: 'Search', prefixIcon: Icon(Iconsax.search_normal)),

              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              Obx(
                () { 
                  // Orders and selected rowsa re hidden => just to update the UI => Obx [itemsRows]
                  Visibility(visible: false, child: Text(controller.filteredDataList.length.toString()),);
                  return TPaginatedDataTable(
                      
                      /// SORTING
                      sortAscending: controller.sortAscending.value,
                      sortColumnIndex: controller.sortColumnIndex.value,
                      
                                  
                      columns: [
                        DataColumn2(label: Text('column 1')),
                         DataColumn(label: Text('column 2'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
                         DataColumn(label: Text('column 3')),
                         DataColumn(label: Text('column 4'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
                      ],
                      source:MyData()
                      
                      
                  );
                } 
              ),
            ],
          )
        
      ),
    );
  }
}

class MyData extends DataTableSource {
  final DashboardController1 controller = Get.put(DashboardController1());
  @override
  DataRow? getRow(int index) {
    final data = controller.filteredDataList[index];
    return DataRow2(
      onTap: (){},
      selected: controller.selectedRows[index],
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
      DataCell(Text(data['Columun1'] ?? '')),
       DataCell(Text(data['Columun2'] ?? '')),
        DataCell(Text(data['Columun3'] ?? '')),
         DataCell(Text(data['Columun4'] ?? '')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredDataList.length;

  @override
  int get selectedRowCount => 0;
  
}

class DashboardController1 extends GetxController {
    var dataList = <Map<String, String>>[].obs;
  var filteredDataList = <Map<String, String>>[].obs;

  RxList<bool> selectedRows = <bool>[].obs;

  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController(); // Handels search text input


  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void sortById(int sortColumnIndex, bool ascending){
    sortAscending.value = ascending;
    filteredDataList.sort((a,b){
      if(ascending){
        return filteredDataList[0]['column1'].toString().toLowerCase().compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
      }else{
        return filteredDataList[0]['column1'].toString().toLowerCase().compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
      }

    });

    this.sortColumnIndex.value = sortColumnIndex;

  }

  void searchQuery(String query){
   filteredDataList.assignAll(dataList.where((item) => item['column1']!.contains(query.toLowerCase())));

  }

  void fetchDummyData(){
    selectedRows.assignAll(List.generate(36, (index) => false));

    dataList.addAll(List.generate(36, (index) => {
      'Columun1' : 'Data ${index + 1} - 1 ',
       'Columun2' : 'Data ${index + 1} - 2 ',
        'Columun3' : 'Data ${index + 1} - 3 ',
         'Columun4' : 'Data ${index + 1} - 4 ',
    }));

    filteredDataList.addAll(List.generate(36, (index) => {
      'Columun1' : 'Data ${index + 1} - 1 ',
       'Columun2' : 'Data ${index + 1} - 2 ',
        'Columun3' : 'Data ${index + 1} - 3 ',
         'Columun4' : 'Data ${index + 1} - 4 ',
    }));
  }

}