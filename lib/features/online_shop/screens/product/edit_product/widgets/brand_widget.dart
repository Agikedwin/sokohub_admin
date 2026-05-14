import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        children: [
          // Brand label

          Text('Brand', style: Theme.of(context).textTheme.headlineSmall,),
          SizedBox(height: TSizes.spaceBtwItems,),

          //TypeAheadField for brand selection

          TypeAheadField(
            builder: (context, ctr, FocusNode){
              return TextFormField(
                focusNode: FocusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Brand',
                  suffixIcon:  Icon(Iconsax.box)
                ),
              );
            }, 
            suggestionsCallback: (pattern){
              return [
                BrandModel(id: 'id', name: 'Nike', image: TImages.nikeLogo),
                 BrandModel(id: 'id', name: 'Adidas', image: TImages.adidasLogo),
                  BrandModel(id: 'id', name: 'Nike', image: TImages.acerlogo)
              ];
            },
            itemBuilder:(context, suggestion){
              return ListTile(title: Text(suggestion.name),);
            },
            onSelected: (suggestion){}, 
            
            )
        ],
      ),
    );
  }
}