class ITRoutes {
  static const login = '/login';
  static const forgetPassword = '/forget-password';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  /// Banners
  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  ///Category
  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  ///Brands
  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

    ///Products
  static const products = '/product';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

   ///Products
  static const customers = '/customers';
  static const customerDetail = '/customerDetail';
  static const editCustomer = '/editCustomer';

   ///Products
  static const orders = '/orders';
  static const ordersDetail = '/ordersDetail';

     // Profile and settings
  static const profile = '/profile';
  static const settings = '/settings';
  

  static List siderbarMenuItems = [
    dashboard, media, categories, brands, banners, customers, orders, ordersDetail
  ];
}
