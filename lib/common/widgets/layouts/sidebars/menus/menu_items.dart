
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ITMenuItemes extends StatelessWidget {
  const ITMenuItemes({
    super.key, required this.route, required this.icon, required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());

    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering ? menuController.changeHoverItem(route) : menuController.changeHoverItem(''),
      child: Obx(
        () => Padding(
          
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color:  menuController.isHovering(route) || menuController.isActive(route) ? TColors.primary : Colors.transparent ,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusMd)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icons
                Padding(
                  padding: EdgeInsets.only(left: TSizes.lg, top: TSizes.md, right: TSizes.md, bottom: TSizes.md),
                  child: menuController.isActive(route)
                  ? Icon(icon, size: 22, color: TColors.white,)
                  : Icon(icon,size: 22, color: menuController.isHovering(route) ? TColors.white : TColors.darkGrey,)
                  
                ),
                if(menuController.isHovering(route) || menuController.isActive(route))
                Flexible(child: Text(itemName, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),))
                else
                Flexible(child: Text(itemName, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.darkGrey),))
              ],
            ),
          
          ),
        ),
      ),
    );
  }
}