import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';

import 'package:sokohub_admin/features/tailor_shop/model/material_model.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/material/material_repository.dart';



class MaterialController extends TBaseController<MaterialModel>{

  static MaterialController get instance => Get.find();


  final materialRepository = Get.put(MaterialRepository());

  TextEditingController materialTextField = TextEditingController();

  Rx<MaterialModel> selectedMaterial = MaterialModel.empty().obs;


  @override
  bool containsSearchQuery(MaterialModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(MaterialModel item) async{
    await materialRepository.deleteMaterial(item.id);
  }
  
  @override
  Future<List<MaterialModel>> fetchItems()  async{
    return await materialRepository.getAllMaterials();
  }
  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (MaterialModel material) => material.name.toLowerCase());
  }
  


}