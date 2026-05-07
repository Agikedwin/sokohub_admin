/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/common/widgets/loaders/circular_loader.dart';
import 'package:sokohub_admin/common/widgets/texts/section_heading.dart';
import 'package:sokohub_admin/features/persionalizations/models/address_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/helpers/cloud_helper_functions.dart';
import 'package:sokohub_admin/utils/helpers/network_manager.dart';
import 'package:sokohub_admin/utils/popups/full_screen_loader.dart';
import 'package:sokohub_admin/utils/popups/loaders.dart';


class AddressController  extends GetxController{
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState>  addressFormKey = GlobalKey<FormState>();
  RxBool refreshData = true.obs;

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  //final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  
  Future<List<AddressModel>> getAllUseraddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty(),);
      return addresses;
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
      
    }
  }

  Future selectAddress(AddressModel newSelectedaddress) async{
    try {
      // Display loader
      Get.defaultDialog(
        title: '',
        onWillPop: () async{
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const TCircularLoader()
      );
      // clear the selected field
      if(selectedAddress.value.id.isNotEmpty){
       // await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign the selected address
      newSelectedaddress.selectedAddress = true;
      selectedAddress.value = newSelectedaddress;

      // set the selected field to true for the newly selected address

     // await addressRepository.updateSelectedField(selectedAddress.value.id, true);
      Get.back();

      
      
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error in selection', message: e.toString());
      
    }
  }

  /// Add new address
  
  Future<void> addNewAddress() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Storing Address...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Address
     final address = AddressModel(
      id: '',
      name: name.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      street: street.text.trim(),
      city: city.text.trim(),
      state: state.text.trim(),
      postalCode: postalCode.text.trim(),
      country: country.text.trim(),
      );
      final id = await addressRepository.addAddress(address);

      // update selected address status
      address.id = id;
      await selectAddress(address);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Address has been saved successfully.');

      // refresh address data
      refreshData.toggle();

      // Reset Fields
      resetFormFields();

      // Redirest
       Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Show Address ModalBottomSheet
  
  Future<dynamic> selectNewAddressPopup(BuildContext context){
    return showModalBottomSheet(

      context: context,
       builder: (_) => Container(
        padding: EdgeInsets.all(ITSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Select Address', showActionButton: false,),
            FutureBuilder(
              future: getAllUseraddresses(),
               builder: (_, snapShot){
                // helper function ---

                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapShot);
                if(response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapShot.data!.length,
                  itemBuilder: (_, index) =>  ITSingeleAddress(
                    address: snapShot.data![index],
                   onTap: () async {
                    await selectAddress(snapShot.data![index]);

                    Get.back();
                   }
                   ),
                );

               }
               ),

               const SizedBox(height: ITSizes.defaultSpace /2,),
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: Text('Add new address')),
               )

          ],
        ),
       )
      );
  }

  void resetFormFields() {
  name.clear();
  phoneNumber.clear();
  street.clear();
  city.clear();
  state.clear();
  postalCode.clear();
  country.clear();

  addressFormKey.currentState?.reset(); //
}


} */