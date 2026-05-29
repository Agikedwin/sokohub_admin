import 'package:get/get.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/features/tailor_shop/model/garment.dart';
import 'package:sokohub_admin/features/tailor_shop/repository/garment/garment_repository.dart';




class GarmentController extends TBaseController<GarmentModel>{

  static GarmentController get instance => Get.find();


  final materialRepository = Get.put(GarmentRepository());


  @override
  bool containsSearchQuery(GarmentModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
  
  @override
  Future<void> deleteItems(GarmentModel item) async{
    await materialRepository.deleteGarment(item.id);
  }
  
  @override
  Future<List<GarmentModel>> fetchItems()  async{
    return await materialRepository.getAllGarments();
  }
  


  ///Sorting
  void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (GarmentModel material) => material.name.toLowerCase());
  }
  


}