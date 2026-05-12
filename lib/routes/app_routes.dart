import 'package:get/get.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/forget_password.dart';
import 'package:sokohub_admin/features/authentication/screens/login/login.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/reset_password.dart';
import 'package:sokohub_admin/features/media/screens/media.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/brands.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/create_brand.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/edit_brand.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/categories.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/create_categories.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/edit_category.dart';
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
      

      // Categories
       GetPage(name: ITRoutes.categories, page: () => const CategoriesScreen(), middlewares: [ITRoutesMiddleware()]),
        GetPage(name: ITRoutes.createCategory, page: () => const CreateCategoriesScreen(), middlewares: [ITRoutesMiddleware()]),
         GetPage(name: ITRoutes.editCategory, page: () => const EditCategoryScreen(), middlewares: [ITRoutesMiddleware()]), 


         // Brands
       GetPage(name: ITRoutes.brands, page: () => const BrandsScreen(), middlewares: [ITRoutesMiddleware()]),
        GetPage(name: ITRoutes.createBrand, page: () => const CreateBrandScreen(), middlewares: [ITRoutesMiddleware()]),
         GetPage(name: ITRoutes.editBrand, page: () => const EditBrandScreen(), middlewares: [ITRoutesMiddleware()]), 
  ];
}