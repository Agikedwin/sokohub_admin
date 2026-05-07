import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/enums.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class ITHeader extends StatelessWidget implements PreferredSizeWidget {
  const ITHeader({super.key, this.scaffoldKey});

  /// GlobalKey to access the scaffold
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        /// Mobile Menu
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(onPressed: () => scaffoldKey!.currentState?.openDrawer(), 
            icon: const Icon(Iconsax.menu))
            : null,

        ///Search Field
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal),
                      hintText: 'Search anything...'),
                ),
              )
            : null,

        /// Actions
        actions: [
          /// Search icon on mobile
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.search_normal)),

          //Notification icon
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),

          /// User Data

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              TRoundedImage(
                width: 40,
                padding: 2,
                height: 40,
                imageType: ImageType.asset,
                image: TImages.user,
              ),
              SizedBox(
                width: TSizes.sm,
              ),

              // Name and Email
              if (!TDeviceUtils.isMobileScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agik Edwin',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'agikedwin@gmail.com',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
