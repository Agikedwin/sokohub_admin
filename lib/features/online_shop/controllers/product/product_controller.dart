import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:sokohub_admin/data/abstract/base_data_table_controller.dart';
import 'package:sokohub_admin/data/repositories/products/product_repository.dart';
import 'package:sokohub_admin/features/online_shop/models/product_model.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';

class ProductController extends TBaseController<ProductModel> {

  static ProductController get instance => Get.find();

  final productRepository = Get.put(ProductRepository());


  @override
  Future<List<ProductModel>> fetchItems()  async{
    return await productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
    item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
    item.stock.toString().toLowerCase().contains(query.toLowerCase()) ||
    item.price.toString().toLowerCase().contains(query.toLowerCase());
    }

  @override
  Future<void> deleteItems(ProductModel product) async{
    await productRepository.deleteProduct(product);
  }

  // Sorting related code
   void sortByName(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.title.toLowerCase());
   }

     // Sorting related code
   void sortByStock(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.stock);
   }

     // Sorting related code
   void sortBySoldItems(int sortColumnIndex, bool ascending){
    sortByProperty(sortColumnIndex, ascending, (ProductModel product) => product.soldQuantity);
   }


/// Get product price or price range
String getProductPrice(ProductModel product){


  // if no variation exixts, return and simpmpe price or sale prce

  if(product.productType == ProductType.variable.name.toString() || product.productVariations!.isEmpty){  //ProductType.single.toString()

    return (product.salePrice > 0.0 ? product.salePrice : product.price).toString();
  }else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;
    // Calculate the smallest and the lasrgest price among variations
    for (var variation in product.productVariations!){
      //Determie the price to consider
      double? priceToConsider = variation.salePrice! > 0.0 ? variation.salePrice: variation.price;

      // Update the smallest and the largest prices

      if(priceToConsider < smallestPrice){
        smallestPrice = priceToConsider; // priceToConsider;
      }

      if(priceToConsider > largestPrice){
         
        largestPrice = priceToConsider;
      }

    }    
    // if the smallest price and the largest price are the same, return single price
      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }else{
        // Otherwise return a price ranbe
        return ' $smallestPrice - $largestPrice';
      }
  }
    

}

/// Calculate Discount Percentage

String? calculateSalePercentage(double originalPrice, double? salePrice){
  if(salePrice == null || salePrice <= 0.0) return null;
  if(originalPrice <= 0) return null;

  double percentage = ((originalPrice - salePrice)/ originalPrice) * 100;
  return percentage.toStringAsFixed(0);
}

/// Calculate Product Stock
String getProductStockTotal(ProductModel product){
  return product.productType == ProductType.single.name.toString() ? product.stock.toString() :
  product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.soldQuantity).toString();
}

/// Calculate Product Sold Quantity
String getProductSoldQuantity(ProductModel product){
  return product.productType == ProductType.single.name.toString() ? product.soldQuantity.toString() :
  product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.soldQuantity).toString();
}


/// Get Product stock status
String getProductStockStatus(int stock){
  return stock > 0 ? 'In Stock' : 'Out of Stock';
}


  
}