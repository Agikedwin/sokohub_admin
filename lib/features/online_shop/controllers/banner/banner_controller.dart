import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/banner/banner_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';


class BannerController extends TBaseController<BannerModel> {
  static BannerController get instance => Get.find();


  final bannerRepository = Get.put(BannerRepository());
  
  @override
  bool containsSearchQuery(BannerModel item, String query) {
   return false;
  }
  
  @override
  Future<void> deleteItems(BannerModel item) async{
    return bannerRepository.deleteBanner(item.id ?? '');
  }

  //Method for formatting a route String
  String formatRoute(String route){
    if(route.isEmpty) return '';

    // Remove the leading '/'
    String formatted = route.substring(1);

    //Capitalize the first character
    formatted = formatted[0].toUpperCase() + formatted.substring(1);
    return formatted;
  }
  
  @override
  Future<List<BannerModel>> fetchItems() async{

    return await bannerRepository.getAllBanners();
  }

}
