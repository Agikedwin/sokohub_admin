import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        children: [
          // Categories label

          Text('Categories', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          MultiSelectDialogField(
            buttonText: const Text('Select Categories'),
            title: const Text('Categories'),

            items: [
              MultiSelectItem(CategoryModel(id: 'id', name: 'Shoes', image: 'image', isFeatured: false), 'shoes'),
               MultiSelectItem(CategoryModel(id: 'id', name: 'Electronics', image: 'image', isFeatured: false), 'Electronics'),
                MultiSelectItem(CategoryModel(id: 'id', name: 'Shirts', image: 'image', isFeatured: false), 'Shirts'),
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values){},
             )
        ],
      ),
    );
  }
}