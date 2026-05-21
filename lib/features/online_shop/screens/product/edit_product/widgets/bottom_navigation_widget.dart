import 'package:flutter/material.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/controllers/brand/edit_category_controller.dart';
import 'package:sokohub_admin/features/online_shop/controllers/product/edit_product_controller.dart';
import 'package:sokohub_admin/features/online_shop/models/category_model.dart';
import 'package:sokohub_admin/features/online_shop/models/product_model.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductBottomNavigationWidget extends StatelessWidget {
  const ProductBottomNavigationWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard button

          OutlinedButton(onPressed: (){}, child: const Text('Discard')),
          SizedBox(width: TSizes.spaceBtwInputFields ,),

          //Save Changes button
          SizedBox(width: 160, child: ElevatedButton(onPressed: () => EditProductController.instance.editeProduct(product),
           child: const Text('Update')),)

          
             
        ],
      ),
    );
  }
}