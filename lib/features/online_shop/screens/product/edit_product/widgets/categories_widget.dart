import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/edit_product_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/helpers/cloud_helper_functions.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});

 final  ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController =EditProductController.instance;
    return TRoundedContainer(
      child: Column(
        children: [
          // Categories label

          Text('Categories', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          FutureBuilder(
            future: productController.loadSelectedCategories(product.id!) ,
            builder: (context, snapshot) {
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
              if(widget != null) return widget;

               return MultiSelectDialogField(
              buttonText: const Text('Select Categories'),
              title: const Text('Categories'),
            
              items: CategoryController.instance.allItems.map((category) => MultiSelectItem(category, category.name)).toList(),
              initialValue: List<CategoryModel>.from(productController.selectedCategories),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values){
                productController.selectedCategories.assignAll(values);
              },
               );
            },

           
          )
        ],
      ),
    );
  }
}