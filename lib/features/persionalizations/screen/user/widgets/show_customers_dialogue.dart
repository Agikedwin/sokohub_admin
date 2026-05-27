import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/online_shop/controllers/category/category_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/create_product_controller.dart';

import 'package:sokohub_admin/utils/constants/sizes.dart';

class ShowCustomersDialogue extends StatelessWidget {
  const ShowCustomersDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    final  categoryController = Get.put(CategoryController());

    if(categoryController.allItems.isEmpty){
      categoryController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        children: [
          // Categories label

          Text('Categories', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          Obx(
            () => categoryController.isLoading.value 
            ? const  TShimmerEffect(width: double.infinity, height: 40)
            : 
            
            MultiSelectDialogField(
              buttonText: const Text('Select Categories'),
              title: const Text('Categories'),
            
              items: categoryController.allItems.map((category) => MultiSelectItem(category, category.name)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values){
                CreateProductController.instance.selectedCategories.assignAll(values);
              },
               ),
          )
        ],
      ),
    );
  }
}