import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/online_shop/controllers/customer/customer_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/order/order_controller.dart';

import 'package:sokohub_admin/features/persionalizations/models/user_model.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/accessory/accessory_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/material/material_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/measuremnt/measurement_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/task/task_controller.dart';

import 'package:sokohub_admin/features/tailor_shop/model/client_selection_attributes_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';

import 'package:sokohub_admin/features/tailor_shop/repository/selection/client_selection_order_repository.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class EditClientSelectionOrderController extends GetxController {
  static EditClientSelectionOrderController get instance => Get.find();

  final clientSelectionOrderRepository =
      Get.put(ClientSelectionOrderRepository());

  final selectedParent = ClientSelectionAttributesModel.empty().obs;
  final isLoading = false.obs;
  TextEditingController description = TextEditingController();



  // This selection order variable
  Rx<ClientSelectionAttributesModel> selectedClientSelection =
      ClientSelectionAttributesModel.empty().obs;
  
  Rx<String> actionCreateEditView = 'CREAT'.obs;

  final formKey = GlobalKey<FormState>();

  // Pick thumbnail image from media

  // Register new category

  void init(ClientSelectionAttributesModel selected){
    
    CustomerController.instance.selectedClient.value = selected.client!;

    // init measurements and accessories
    MeasurementController.instance.getEditEnteredValues(selected.measurements);
    AccessoryController.instance.getEditEnteredValues(selected.accessories);

    // Set fetched items from collection
    CustomerController.instance.selectedClient.value = selected.client!;
    GarmentController.instance.selectedGarment.value = selected.garment;
    MaterialController.instance.selectedMaterial.value = selected.material;

    // Get already assigned assigned tasks to the garment
    TasksController.instance.loadSelectedGarmentTasks(selected.garment.id); 

    
  }

  Future<void> editClientSelectionOrder(ClientSelectionAttributesModel model) async {
    try {
      // Start loading
      TFullScreenLoader.popUpCircular();

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: 'Check your internet connection');
        return;
      }

      // Assig models data

      //selectionModel.client = CustomerController.instance.selectedClient;

      ClientSelectionAttributesModel clientOrder = garmentSelectionAttributesData(model.id);

       await clientSelectionOrderRepository
          .updateClientSelectionOrder(clientOrder); 

      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success message
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'New record successfully added');

     // GarmentSelectionController.instance.addItemTolist(clientOrder);
      
      Get.back();
    } catch (e, trace) {
      print(trace);
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong: $e');
    }
  }

  ClientSelectionAttributesModel garmentSelectionAttributesData(String selectionId) {
    // instances
    final user = CustomerController.instance.selectedClient.value;
    final garment = GarmentController.instance.selectedGarment.value;
    final material = MaterialController.instance.selectedMaterial.value;
    final measurements = MeasurementController.instance;
    final accessory = AccessoryController.instance;
    final order = OrderController.instance;
    final garmentTasks = TasksController.instance.alreadySelectedGarmentTasks;
    // final cartItem = OrderController.instance.order

    // Set measurements
    measurements.getClientMeasurements();

    // Set clientAccessory
    accessory.getClientAccessory();

    // client Model
    ClientSelectionAttributesModel model = ClientSelectionAttributesModel(
        id: selectionId,
        userId: order.selectedOrder.value.userId,
        client: UserModel(
            id: user.id,
            email: user.email,
            lastName: user.firstName,
            phoneNumber: user.phoneNumber,
            isEmailVerified: user.isEmailVerified,
            isProfileActive: user.isProfileActive),
        tailorsAssigned: [],
        garment: GarmentModel(
            id: garment.id,
            name: garment.name,
            image: garment.image,
            wage: garment.wage),
        clientOrder: order.selectedClientCart.value,
        material: MaterialModel(
            id: material.id,
            name: material.name,
            unitCost: material.unitCost,
            image: material.image),
        accessories: accessory.clientAccessory,
        measurements: measurements.clientMeasurements,
        garmentTasks: garmentTasks,
        orderDate: DateTime.now(),
        paymentMethod: '',

        orderId: order.selectedOrder.value.orderId ?? '',
        description: description.text.trim().toString(),
        status: OrderStatus.processing
        );

    return model;
  }

  // Method to reser fields
  // Method to reset fields
  void resetFields() {
    // Clear selected client
    CustomerController.instance.selectedClient.value = UserModel.empty();

    // Clear selected garment
    GarmentController.instance.selectedGarment.value = GarmentModel.empty();

    // Clear selected material
    MaterialController.instance.selectedMaterial.value = MaterialModel.empty();

    // Clear measurements
    MeasurementController.instance.clientMeasurements.clear();

    // Clear accessories
    AccessoryController.instance.clientAccessory.clear();

    // Clear selected order

    // Clear description
    description.clear();

    // Optional: clear payment method if it's a TextEditingController

    // Refresh GetX observables if necessary
    CustomerController.instance.selectedClient.refresh();
    GarmentController.instance.selectedGarment.refresh();
    MaterialController.instance.selectedMaterial.refresh();
    OrderController.instance.selectedOrder.refresh();
  }
}
