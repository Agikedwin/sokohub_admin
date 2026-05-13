import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/menus/menu_items.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ITSidebar extends StatelessWidget {
  const ITSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1)),
        ),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              // Image
              TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: TSizes.spaceBtwSections,),

              Padding(
                padding:  EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),

                    // Menu Items
                    const ITMenuItemes(route: ITRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard',),
                    const ITMenuItemes(route: ITRoutes.media, icon: Iconsax.image, itemName: 'Media',),
                    const ITMenuItemes(route: ITRoutes.categories, icon: Iconsax.category_2, itemName: 'Categories',),
                    const ITMenuItemes(route: ITRoutes.brands, icon: Iconsax.dcube, itemName: 'Brands',),
                    const ITMenuItemes(route: ITRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banners',),
                    const ITMenuItemes(route: ITRoutes.products, icon: Iconsax.shopping_bag, itemName: 'Prouducts',)


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

