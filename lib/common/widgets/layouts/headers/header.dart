import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/images/t_rounded_image.dart';
import 'package:sokohub_admin/common/widgets/shimmers/shimmer.dart';
import 'package:sokohub_admin/features/persionalizations/controllers/user_controller.dart';
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
    final controller = Get.put(UserController());
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
              Obx(
                () => TRoundedImage(
                  width: 40,
                  padding: 2,
                  height: 40,
                  imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : TImages.user,
                ),
              ),
              SizedBox(
                width: TSizes.sm,
              ),

              // Name and Email
                          // Name and Email
            if (!TDeviceUtils.isMobileScreen(context))
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.loading.value
                        ? const TShimmerEffect(width: 80, height: 12)
                        : Text(
                            controller.user.value.fullName,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),

                    const SizedBox(height: 4),

                    controller.loading.value
                        ? const TShimmerEffect(width: 120, height: 10)
                        : Text(
                            controller.user.value.email,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ],
                ),
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
