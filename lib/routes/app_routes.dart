import 'package:get/get.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/forget_password.dart';
import 'package:sokohub_admin/features/authentication/screens/login/login.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/reset_password.dart';
import 'package:sokohub_admin/features/media/screens/media.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_skeleton.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/routes/routes_middleware.dart';

class ITAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: ITRoutes.login, page: () => const LoginScreen(), middlewares: [ITRoutesMiddleware()]),
     GetPage(name: ITRoutes.forgetPassword, page: () => const ForgetPasswordScreen(), middlewares: [ITRoutesMiddleware()]),
      GetPage(name: ITRoutes.resetPassword, page: () => const ResetPasswordScreen(), middlewares: [ITRoutesMiddleware()]), 
      GetPage(name: ITRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.media, page: () => const MediaScreen(), middlewares: [ITRoutesMiddleware()]),
  ];
}