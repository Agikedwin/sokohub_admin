import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/forget_password.dart';
import 'package:sokohub_admin/features/authentication/screens/login/login.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/reset_password.dart';
import 'package:sokohub_admin/features/media/screens/media.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/banner.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/create_banner/create_banner.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/edit_banner/edit_banner.dart';

import 'package:sokohub_admin/features/online_shop/screens/brands/all_brands/brands.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/create_brand/create_brand.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/edit_brand.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/all_categories/categories.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/create_category/create_categories.dart';
import 'package:sokohub_admin/features/online_shop/screens/category/edit_category/edit_category.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/customers.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/all_customers/responsive_screens/customer_mobile.dart';
import 'package:sokohub_admin/features/online_shop/screens/customer/customer_detail/customer.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/all_orders/orders.dart';
import 'package:sokohub_admin/features/online_shop/screens/order/order_detail/order_detail.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/all_products/products.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/create_product.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/edit_product/edit_product.dart';
import 'package:sokohub_admin/features/online_shop/screens/responsive_skeleton.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/profile.dart';
import 'package:sokohub_admin/features/persionalizations/screen/settings/settings.dart';
import 'package:sokohub_admin/features/persionalizations/screen/user/user.dart';
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

          // Banners
       GetPage(name: ITRoutes.banners, page: () => const BannerScreen(), middlewares: [ITRoutesMiddleware()]),
         GetPage(name: ITRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [ITRoutesMiddleware()]),
          GetPage(name: ITRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [ITRoutesMiddleware()]),  

            // Banners
       GetPage(name: ITRoutes.products, page: () => const ProductScreen(), middlewares: [ITRoutesMiddleware()]),
         GetPage(name: ITRoutes.createProduct, page: () => const CreateProductScreen(), middlewares: [ITRoutesMiddleware()]),
         GetPage(name: ITRoutes.editProduct, page: () => const EditProductScreen(), middlewares: [ITRoutesMiddleware()]),   


        // Customers
       GetPage(name: ITRoutes.customers, page: () => const CustomerScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.customerDetail, page: () => const CustomerDetailScreen(), middlewares: [ITRoutesMiddleware()]),

        // Orders
       GetPage(name: ITRoutes.orders, page: () => const OrderScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.ordersDetail, page: () => const OrderDetailScreen(), middlewares: [ITRoutesMiddleware()]),

     
       // Profile
       GetPage(name: ITRoutes.profile, page: () => const ProfileScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.settings, page: () => const SettingsScreen(), middlewares: [ITRoutesMiddleware()]),

       // User
       GetPage(name: ITRoutes.user, page: () => const UserScreen(), middlewares: [ITRoutesMiddleware()]),
  ];
}