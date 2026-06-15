import 'package:get/get.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';


import 'package:sokohub_admin/features/tailor_shop/repository/selection/garment_selection_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';



class ClientGarmentOrderController extends GetxController{

  static ClientGarmentOrderController get instance => Get.find();


  final garmentSelectionRepository = Get.put(GarmentSelectionRepository());
  final  garmentController = GarmentController.instance;

  RxBool isLoading = false.obs;


  Rx<ClientSelectionAttributesModel> selectedGarmentSelection = ClientSelectionAttributesModel.empty().obs;

  Rx<ClientSelectionAttributesModel> clientGarmentSelection = ClientSelectionAttributesModel.empty().obs;

@override
  void onInit() {
    final clientGarmentId = Get.parameters['clientGarmentId'];
    getClientSelectionOrdersById(clientGarmentId!);
    super.onInit();
  }


  Future<void> getClientSelectionOrdersById(String clientSelectionId) async{

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
         
          // Set the selection garment
          garmentController.currentGarmentSelected.clear();
          garmentController.currentGarmentSelected.add(result.garment);

          isLoading.value = false;
          //clientGarmentSelection.refresh();


        //  TFullScreenLoader.stopLoading();
           

      
    } catch (e, trace) {
      print(trace);
       isLoading.value = false;
     // TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong: $e');
    }

  }
  


}