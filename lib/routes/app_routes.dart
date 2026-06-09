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
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/all_accessory/accessory.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/create_accessory/create_accessory.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/accessory/edit_accessory/edit_material.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/all_garments/garment.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/attribute/garment_attribute.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/create_garment/create_garment.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment/edit_garment/edit_garment.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/garment_orders/client_garment_order.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/all_material/material.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/create_material/create_material.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/edit_material.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/all_measurements/measurements.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/create_measurements/create_measurements.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/edit_measurements/edit_measurements.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/all_selections/garment_selection.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/create_selection/client_garment_selection.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/selection/edit_selection/edit_garment_selection.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/all_tasks/tasks.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/tasks/create_task/create_task.dart';
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

       // Tailor Dhop

       // Material
       GetPage(name: ITRoutes.material, page: () => const MaterialScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.editMaterial, page: () => const EditMaterialScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.createMaterial, page: () => const CreateMaterialScreen(), middlewares: [ITRoutesMiddleware()]),

        // Garment
       GetPage(name: ITRoutes.garment, page: () => const GarmentScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.editGarment, page: () => const EditGarmentScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.createGarment, page: () => const CreateGarmentScreen(), middlewares: [ITRoutesMiddleware()]),

        // Measuremnt
       GetPage(name: ITRoutes.measurement, page: () => const MeasurementScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.editMeasurement, page: () => const EditMeasurementScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.createMeasurement, page: () => const CreateMeasurementScreen(), middlewares: [ITRoutesMiddleware()]),

        // Accessory
       GetPage(name: ITRoutes.accessory, page: () => const AccessoryScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.editAccessory, page: () => const EditAccessoryScreen(), middlewares: [ITRoutesMiddleware()]),
       GetPage(name: ITRoutes.createAccessory, page: () => const CreateAccessoryScreen(), middlewares: [ITRoutesMiddleware()]),

       GetPage(name: ITRoutes.garmentInfo, page: () => const GarmentAttributeScreen(), middlewares: [ITRoutesMiddleware()]),

       // Garment client selection
       GetPage(name: ITRoutes.createGarmentSelection, page: () => const CreateClientGarmentSelectionScreen(), middlewares: [ITRoutesMiddleware()]),

       // clietSelection
      GetPage(name: ITRoutes.clientSelection, page: () => const GarmentSelectionScreen(), middlewares: [ITRoutesMiddleware()]),
      
      GetPage(name: ITRoutes.editGarmentSelection, page: () => const EditClientGarmentSelectionScreen(), middlewares: [ITRoutesMiddleware()]),

      //client Garment  
      GetPage(name: ITRoutes.clientGarment, page: () => const ClientGarmentOrderScreen(), middlewares: [ITRoutesMiddleware()]),

      //TasksScreen
      GetPage(name: ITRoutes.task, page: () => const TasksScreen(), middlewares: [ITRoutesMiddleware()]),
      GetPage(name: ITRoutes.createTask, page: () => const CreateTasksScreen(), middlewares: [ITRoutesMiddleware()]),
      GetPage(name: ITRoutes.editTask, page: () => const EditBrandScreen(), middlewares: [ITRoutesMiddleware()]),

  ];
}