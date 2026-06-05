import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/controllers/garment/garment_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_measuremnt_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment_model.dart';
import 'package:sokohub_admin/features/tailor_shop/model/measurement_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/measurement/measurement_repository.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';

class MeasurementController extends TBaseController<MeasurementModel> {
  static MeasurementController get instance => Get.find();

  final measurementRepository = Get.put(MeasurementRepository());

  //final measurementController = Get.put(MeasurementController());

  RxBool measurementLoading = false.obs;

  final RxList<MeasurementModel> selectedMeasurement = <MeasurementModel>[].obs;
  final RxList<MeasurementModel> clientMeasurements = <MeasurementModel>[].obs;

  final RxList<MeasurementModel> alreadySelectedMeasurement =
      <MeasurementModel>[].obs;

  /* final RxList<TextEditingController> valueControllers =
      <TextEditingController>[].obs; */

  RxMap<String, String> textFieldList = <String, String>{}.obs;
  RxList<MeasurementModel> selectedClientMeasurements = <MeasurementModel>[].obs;

  RxList<GarmentMeasurementModel> selectedGarmentMeasuremnt =
      <GarmentMeasurementModel>[].obs;
      // List to store controllers for each variiation attribute
    List<Map<MeasurementModel, TextEditingController>> valueControllersList = [];

  @override
  bool containsSearchQuery(MeasurementModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItems(MeasurementModel item) async {
    await measurementRepository.deleteMeasurement(item.id);
  }

  @override
  Future<List<MeasurementModel>> fetchItems() async {
    return await measurementRepository.getAllMeasurements();
  }

  @override
  void onClose() {
    for (final controller in valueControllersList) {
      controller.clear();
    }
    super.onClose();
  }

  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (MeasurementModel material) => material.name.toLowerCase());
  }

  void assignNewMeasurement(List<MeasurementModel> data) {
    selectedMeasurement.assignAll(data);
  }

// Set the client provided measurements
  void getClientMeasurements() {
  clientMeasurements.clear();

  for (final measurementMap in valueControllersList) {
    for (final entry in measurementMap.entries) {
      final measurement = entry.key;
      final controller = entry.value;

      final value = controller.text.trim();

      if (value.isEmpty || double.tryParse(value) == 0) {
        throw 'Please provide value for ${measurement.name}';
        
        // Handle validation error
      } else {
        // Add valid measurement
        clientMeasurements.add(measurement);
      }
    }
  }
}
  

  // Populate the input text
  Future<void> getEnteredValues(GarmentModel garment) async {
    // Load garment measurements if not already loaded
      final measurements =
          await measurementRepository.getAllGarmentMeasuremnt(garment.id);

      selectedGarmentMeasuremnt.assignAll(measurements);
    

    // Extract measurement IDs
    final measurementIds =
        selectedGarmentMeasuremnt.map((e) => e.measurementId).toList();

    // Get matching measurement definitions
    final selectedMeasurements =
        allItems.where((item) => measurementIds.contains(item.id)).toList();

     valueControllersList.clear();

      for(var measurent in selectedMeasurements){

     Map<MeasurementModel, TextEditingController> measurementControllers = {};
      measurementControllers[measurent] = TextEditingController(text: measurent.value.toString());
      valueControllersList.add(measurementControllers);

      }

    

     selectedMeasurement.assignAll(selectedMeasurements);
     //textFieldList.value = data;
     //textFieldList.refresh();
  }

  Future<List<MeasurementModel>> loadSelectedMeasuremnts(
      String garmentId) async {
    measurementLoading.value = true;

    // Product categories
    final garmentMeasurement =
        await measurementRepository.getAllGarmentMeasuremnt(garmentId);

    if (allItems.isEmpty) await fetchItems();

    final measurementIds =
        garmentMeasurement.map((e) => e.measurementId).toList();
    final measurements = allItems
        .where((element) => measurementIds.contains(element.id))
        .toList();

    alreadySelectedMeasurement.assignAll(measurements);
    measurementLoading.value = false;

    return measurements;
  }

  Future<void> addGarmentMeasurement() async {
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

      //Register product Garment Measurement  if any
      if (selectedMeasurement.isNotEmpty) {
        // Loop through selected Garment Measurement
        measurementLoading.value = true;

        // Get existing Measurement Ids
        List<String> existingMeasurementIds = alreadySelectedMeasurement
            .map((measurement) => measurement.id)
            .toList();

        for (var measurement in selectedMeasurement) {
          // Check if the Measurement is not already associated with the garment
          if (!existingMeasurementIds.contains(measurement.id)) {
            // Map Data
            final garmentMeasurement = GarmentMeasurementModel(
                id: '',
                garmentId: GarmentController.instance.selectedGarment.value.id,
                measurementId: measurement.id);

            // Save the selected Measurement

            await measurementRepository.assignMeasurement(garmentMeasurement);

            alreadySelectedMeasurement.add(selectedMeasurement
                .firstWhere((item) => item.id == measurement.id));
            alreadySelectedMeasurement.refresh();
          }
        }

        // Remove Accessories not selected by the user
        for (var existingMeasurementId in existingMeasurementIds) {
          // Check if the Measurement is not already associated with the Garment
          if (!selectedMeasurement
              .any((access) => access.id == existingMeasurementId)) {
            // Remove the association
            await measurementRepository.deleteAAssociatedccessory(
                existingMeasurementId,
                GarmentController.instance.selectedGarment.value.id);

            alreadySelectedMeasurement
                .removeWhere((item) => item.id == existingMeasurementId);
            alreadySelectedMeasurement.refresh();
          }
        }

        // Success message
        TLoaders.successSnackBar(
            title: 'Congratulations', message: 'New record successfully added');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'OhSnap', message: 'Something went wrong: $e');
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
