import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_accessory_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/accessory/accessory_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';




class AccessoryController extends TBaseController<AccessoryModel>{

  static AccessoryController get instance => Get.find();

 RxBool accessoryLoading = false.obs;

  final accessoryRepository = Get.put(AccessoryRepository());

  final RxList<GarmentAccessoryModel> garmentAccessory =
    <GarmentAccessoryModel>[].obs;

    final RxList<GarmentAccessoryModel> selectedGarmentAccessory =
    <GarmentAccessoryModel>[].obs;

    final RxList<AccessoryModel> selectedAccessory =
    <AccessoryModel>[].obs;

    final RxList<AccessoryModel> alreadySelectedAccessory =
    <AccessoryModel>[].obs;

    final RxList<TextEditingController> valueControllers =
      <TextEditingController>[].obs;

    RxMap<String, String> textFieldList = <String, String>{}.obs;

     List<Map<AccessoryModel, TextEditingController>> valueControllersList = [];
     final RxList<AccessoryModel> clientAccessory = <AccessoryModel>[].obs;


    
  @override
  bool containsSearchQuery(AccessoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(AccessoryModel item) async{
    await accessoryRepository.deleteAccessory(item.id);
  }
  
  @override
  Future<List<AccessoryModel>> fetchItems()  async{
    return await accessoryRepository.getAllAccessories();
  }
  @override
  void onClose() {
    for (final controller in valueControllersList) {
      controller.clear();
    }
    super.onClose();
  }

  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (AccessoryModel material) => material.name.toLowerCase());
  }

   void assignNewAccessory( List<AccessoryModel> data){
   
    selectedAccessory.assignAll(data);
  } 

// Set the client provided accessories
  void getClientAccessory(){
      clientAccessory.clear();
    for(var i =0; i <= valueControllersList.length-1; i++){
     clientAccessory.addAll(valueControllersList[i].keys.toList());

    }

    

  }

  // Populate the input text
   Future<void> getEnteredValues(GarmentModel garment) async {
    // Load garment accessories if not already loaded
      final accessories =
          await accessoryRepository.getAllGarmentAccessoryById(garment.id);

      selectedGarmentAccessory.assignAll(accessories);
    

    // Extract measurement IDs
    final measurementIds =
        selectedGarmentAccessory.map((e) => e.accessoryId).toList();

    // Get matching measurement definitions
    final selectedAccessories =
        allItems.where((item) => measurementIds.contains(item.id)).toList();

     valueControllersList.clear();

      for(var accessory in selectedAccessories){

     Map<AccessoryModel, TextEditingController> accessoryControllers = {};
      accessoryControllers[accessory] = TextEditingController(text: accessory.quantity.toString());
      valueControllersList.add(accessoryControllers);

      }

    

     selectedAccessory.assignAll(selectedAccessories);
     //textFieldList.value = data;
     //textFieldList.refresh();
  }

    Future<List<AccessoryModel>> loadSelectedAccessories(String garmentId) async{
    accessoryLoading.value = true;

    // Product categories
    final garmentAccessory = await accessoryRepository.getAllGarmentAccessoryById(garmentId);
    final accessoryController = Get.put(AccessoryController());

    if(accessoryController.allItems.isEmpty) await accessoryController.fetchItems();

    final accessoryIds = garmentAccessory.map((e) => e.accessoryId).toList();
    final accessories  = accessoryController.allItems.where((element)=> accessoryIds.contains(element.id)).toList();
    
    
    alreadySelectedAccessory.assignAll(accessories);
    accessoryLoading.value = false;

    return accessories;

  }

   Future<void> addGarmentAccessory() async{
    try {
       TFullScreenLoader.popUpCircular();

        //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }
      // Save all selected Accessories

   

      //Register product Garment Accessory  if any
      if (selectedAccessory.isNotEmpty) {
        // Loop through selected Garment Accessory
        accessoryLoading.value = true;

      // Get existing Accessory Ids
      List<String> existingAccessoryIds = alreadySelectedAccessory.map((aceessory) => aceessory.id).toList();

      for (var accessory in selectedAccessory) {
        
        // Check if the accessory is not already associated with the garment
        if(!existingAccessoryIds.contains(accessory.id)){
          // Map Data
         final garmentAccessory = GarmentAccessoryModel(
          id: '', 
          garmentId: GarmentController.instance.selectedGarment.value.id,
           accessoryId: accessory.id
           );

           // Save the selected Accessory
          
           await  accessoryRepository.assignAccessory(garmentAccessory);

           alreadySelectedAccessory.add(selectedAccessory.firstWhere((item) => item.id == accessory.id));
           
          
        }
        
      }

      // Remove Accessories not selected by the user
      for (var existingAccessoryId in existingAccessoryIds) {
        // Check if the accessory is not already associated with the Garment
        if(!selectedAccessory.any((access) => access.id == existingAccessoryId)){
          // Remove the association
          await  accessoryRepository.deleteAAssociatedccessory(existingAccessoryId, GarmentController.instance.selectedGarment.value.id);

          alreadySelectedAccessory.removeWhere((item) => item.id == existingAccessoryId);
          alreadySelectedAccessory.refresh();
        }
        
      }

        // Success message
        TLoaders.successSnackBar(title: 'Congratulations', message: 'New record successfully added'); 
         alreadySelectedAccessory.refresh(); 
      }
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong: $e');
    }finally{
      TFullScreenLoader.stopLoading();
    }

  }

 
  


}
