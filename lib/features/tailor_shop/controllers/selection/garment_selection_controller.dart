import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';


import 'package:sokohub_admin/features/tailor_shop/repository/selection/garment_selection_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';



class GarmentSelectionController extends TBaseController<ClientSelectionAttributesModel>{

  static GarmentSelectionController get instance => Get.find();


  final garmentSelectionRepository = Get.put(GarmentSelectionRepository());

  TextEditingController garmentSelectionTextField = TextEditingController();

  Rx<ClientSelectionAttributesModel> selectedGarmentSelection = ClientSelectionAttributesModel.empty().obs;

  Rx<ClientSelectionAttributesModel> clientGarmentSelection = ClientSelectionAttributesModel.empty().obs;


  @override
  bool containsSearchQuery(ClientSelectionAttributesModel item, String query) {
    return item.client!.fullName.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(ClientSelectionAttributesModel item) async{
    await garmentSelectionRepository.deleteGarmentSelection(item.id);
  }
  
  @override
  Future<List<ClientSelectionAttributesModel>> fetchItems()  async{
    return await garmentSelectionRepository.getAllGarmentSelections();
  }
  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (ClientSelectionAttributesModel garmentSelection) => garmentSelection.client!.fullName.toLowerCase());
  }

  Future<void> getClientDelectionOrdersById(String clientSelectionId) async{

    try {
      // Start loading
      isLoading.value = true;
     // TFullScreenLoader.popUpCircular() ;

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

      

      final result = await garmentSelectionRepository
          .getAllGarmentSelectionsById(clientSelectionId); 


          clientGarmentSelection.value = result;

          isLoading.value = false;


        //  TFullScreenLoader.stopLoading();
           

      
    } catch (e, trace) {
      print(trace);
       isLoading.value = false;
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong: $e');
    }

  }
  


}