import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';


import 'package:sokohub_admin/features/tailor_shop/repository/selection/garment_selection_repository.dart';



class GarmentSelectionController extends TBaseController<ClientSelectionAttributesModel>{

  static GarmentSelectionController get instance => Get.find();


  final garmentSelectionRepository = Get.put(GarmentSelectionRepository());

  TextEditingController garmentSelectionTextField = TextEditingController();

  Rx<ClientSelectionAttributesModel> selectedGarmentSelection = ClientSelectionAttributesModel.empty().obs;
  Rx<double> totalGarmentAmountToPurchase = 0.0.obs;



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
    final result = await garmentSelectionRepository.getAllGarmentSelections();
    // sum purch cost
    calculateMaterialPurchaseCost(result);
    
    

    return result;
  }
  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (ClientSelectionAttributesModel garmentSelection) => garmentSelection.client!.fullName.toLowerCase());
  }

  

  void calculateMaterialPurchaseCost(List<ClientSelectionAttributesModel> items){
    print('${items.length} ===============================================');
        final result = items.fold(0.0, (prev, items) => prev + (items.material.unitCost * items.material.estimatedLength!));
        print(result);
        totalGarmentAmountToPurchase(result);


  }

}