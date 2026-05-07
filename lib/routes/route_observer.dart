import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:sokohub_admin/routes/routes.dart';

class ITRouteObserver  extends GetObserver{

// // Called when the route is poped from the navigation stack

@override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {

    final sideBarController = Get.put(SidebarController());

    if(previousRoute != null){
      // Check the route name and update the active item in the sidebar accordingly

      for( var routeName in ITRoutes.siderbarMenuItems){
        if(previousRoute.settings.name == routeName){
          sideBarController.activeItem.value = routeName;
        }
      }
    }

  }
/* 
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {

     final sideBarController = Get.put(SidebarController());

    if(route != null){
      // Check the route name and update the active item in the sidebar accordingly

      for( var routeName in ITRoutes.sideMenuItems){
        if(previousRoute.seeting.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
 */

}