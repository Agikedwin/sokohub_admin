
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

abstract class TBaseController<T> extends GetxController{

  final isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
   RxList<T> allItems = <T>[].obs;
   RxList<T> filteredItems = <T>[].obs; 
   RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

/// Abstract method to be implemented by subclass for fetching items
Future<List<T>> fetchItems();

/// Abstract method to be implemented by subclass for deleting an item
Future<void> deleteItems(T item);

/// Abstract method to be implemented by subclass for update an item
//Future<void> updateItems();

/// Abstract method to be implemented by subclass for checking if an otem contains the search query
bool containsSearchQuery(T item, String query);


  @override
  void onInit(){
   fetchData();
    super.onInit();
  }
 
  

  /// Common methon for fetching data
  Future<void> fetchData() async {
    try {
     
      /// Show loader while loading categories
      isLoading.value = true;

      List<T> fetchedItems = [];     

      /// Fetch categories from data source
      if(allItems.isEmpty){
         print('================211');
        fetchedItems = await  fetchItems();  //categoryRepository.getAllCategories();
      }else{
        print('================22');
      }
       
      /// Update the category list
     allItems.assignAll(fetchedItems);
     filteredItems.assignAll(fetchedItems);

     // generate list to assign to the selectable table rows
     selectedRows.assignAll(List.generate(allItems.length, (index) => false));

      isLoading.value = false;
    } catch (e, stack ) {
       isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh, Snap!', message: e.toString());
      
    }finally{
      /// remove Loader
    //  TFullScreenLoader.stopLoading();
      isLoading.value = false;
  }
  /// -- Load selected category data
  /// Get Category or Sub-Category products
}




/// Common method for searching based on a query
  searchQuery(String query){
   filteredItems.assignAll(
    allItems.where((item) => containsSearchQuery(item, query))
   );
  }

/// Common method for sorting items by a property
  void sortByProperty(int sortColumnIndex, bool ascending, Function(T) property) {

     sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
   
    filteredItems.sort((a,b){
      if(ascending){
        return property(a).compareTo(property(b));
      }else{
        return property(b).compareTo(property(a));
      }
    });
  }

  

  void confirmAndDeleteItem(T item) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to Delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(item), 
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight /2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5)),
          ),
          child: Text('Ok')),
      ),
      cancel:  SizedBox(
        width: 60,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight /2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5)),
          ),
          child: Text('Cancel')),
      ),
    );
  }
  
deleteOnConfirm(T item) async {

  try {
    // remove the confirmation Dialogue
  TFullScreenLoader.stopLoading();

  //Start the Loader
  TFullScreenLoader.popUpCircular();

  // Delete Firestore Data
  await deleteItems(item);

  removeItemFromLists(item);

  TFullScreenLoader.stopLoading();
  TLoaders.successSnackBar(title: 'Item Deleted', message: 'Your Item has been Deleted');
    
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    
  }
  

}

// Method for removing Items the list

void removeItemFromLists(T item){
  allItems.remove(item);
  filteredItems.remove(item);
  selectedRows.assignAll(List.generate(allItems.length, (index) => false));  //Initialize selected rows
}

  void addItemTolist(T item) {
    allItems.add(item);
  filteredItems.add(item);
  selectedRows.assignAll(List.generate(allItems.length, (index) => false));  //Initialize selected rows

  filteredItems.refresh();  // refresh UI to reflect the changes
  }

// Method for updating an item in the list

 void updateItemFromlist(T item) {
   final itemIndex = allItems.indexWhere((i) => i == item);
   final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

   if(itemIndex != -1) allItems[itemIndex] = item;
   if(filteredItemIndex != -1){
    filteredItems[itemIndex] = item;
   }
   filteredItems.refresh();  // Refresh the UI to relect the changes

  }
  

    

}