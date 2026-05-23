import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/features/persionalizations/models/address_model.dart';


class AddressRepository  extends GetxController{
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<List<AddressModel>> fetchUserAddress(String userId) async {

   try {
    

    final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
    return result.docs.map((doc)=> AddressModel.fromSnapshot(doc)).toList();
     
   } catch (e) {
    throw 'Something went wrong while fetching address Information. Try again later';
     
   }

  }
  /// Clear the selected field for all addresses
  
  Future<void> updateSelectedField(String addressId, bool selected) async{
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
       await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
      
    } catch (e) {
      throw 'Unable to update your address selection';
      
    }
  }

// Store new user order
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress =await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
      
    } catch (e) {
      throw 'Somethong went wrong while saving address infromation. Try again later';
      
    }
  }

 
}