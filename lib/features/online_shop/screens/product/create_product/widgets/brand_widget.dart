import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/brand_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final  controller = Get.put(CreateProductController());
    final brandController = Get.put(BrandController());

    // fetch brands if the list is empty
    if(brandController.allItems.isEmpty){
      brandController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text('Brand', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          Obx(
            () => brandController.isLoading.value 
            ?   const  TShimmerEffect(width: double.infinity, height: 40)
            : TypeAheadField(
              builder: (context, ctr, FocusNode){
                return TextFormField(
                  controller: controller.brandTextField = ctr,
                  focusNode: FocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Brand',
                    suffixIcon:  Icon(Iconsax.box)
                  ),
                );
              }, 
              suggestionsCallback: (pattern){
                // Return filtered brands suggestions on the search pattern
                return brandController.allItems.where((brand) => brand.name.contains(pattern)).toList();               
              },
              itemBuilder:(context, suggestion){
                return ListTile(title: Text(suggestion.name),);
              },
              onSelected: (suggestion){
                controller.selectedBrand.value = suggestion;
                controller.brandTextField.text = suggestion.name;
              }, 
              
              ) 
          )
        ],
      ),
    );
  }
}