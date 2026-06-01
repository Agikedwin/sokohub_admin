import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/images/t_circular_image.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/menus/menu_items.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/setting_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
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
              Row(
                children: [
                  Obx(
                    () =>TCircularImage(
                width: 100,
                height: 100,
                padding: 0,
                imageType: SettingController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                image: SettingController.instance.settings.value.appLogo.isNotEmpty 
                ? SettingController.instance.settings.value.appLogo
                :   TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
                  ),

                  Expanded(
                    child: Obx(
                      () => Text(
                        SettingController.instance.settings.value.appName,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                  )
                ],
              ),
              
              SizedBox(height: TSizes.spaceBtwSections/ 2,),

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
                    const ITMenuItemes(route: ITRoutes.products, icon: Iconsax.shopping_bag, itemName: 'Prouducts',),
                     const ITMenuItemes(route: ITRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Customers',),
                      const ITMenuItemes(route: ITRoutes.orders, icon: Iconsax.box, itemName: 'Orders',),


                      // ITailor
                   Text('TAILOR', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),
                   const ITMenuItemes(route: ITRoutes.material, icon: Iconsax.magicpen, itemName: 'Material',),
                    const ITMenuItemes(route: ITRoutes.garment, icon: Iconsax.gallery_add, itemName: 'Garment',),
                    const ITMenuItemes(route: ITRoutes.measurement, icon: Iconsax.rulerpen, itemName: 'Measurement',),
                    const ITMenuItemes(route: ITRoutes.accessory, icon: Iconsax.archive_book, itemName: 'Accessory',),

                      // OTHER Menu ITEMS
                   Text('ACTIONS', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),
                   const ITMenuItemes(route: ITRoutes.user, icon: Iconsax.user_add, itemName: 'User',),                
                   

                      //Other Menu Items
                       // OTHER Menu ITEMS
                   Text('SETTINGS', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),
                   const ITMenuItemes(route: ITRoutes.profile, icon: Iconsax.user, itemName: 'Profile',),
                   const ITMenuItemes(route: ITRoutes.settings, icon: Iconsax.setting_2, itemName: 'Settings',),
                   const ITMenuItemes(route: 'logout', icon: Iconsax.logout, itemName: 'Logout',),



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

