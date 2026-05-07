import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:sokohub_admin/routes/routes.dart';

class ITRoutesMiddleware extends GetMiddleware{

@override
RouteSettings? redirect(String? route){

  print('---------------------Middleware----------------------');

  final isAuthenticated = true;
  return isAuthenticated ? null : const RouteSettings(name: ITRoutes.login);


}

}