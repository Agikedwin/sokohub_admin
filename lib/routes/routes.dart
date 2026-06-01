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

      // User, customer, admin
  static const user = '/user';

  // Tailor Shop
  // Material
  static const material = '/material';
  static const createMaterial = '/createMaterial';
  static const editMaterial = '/editMaterial';


  // garment

  static const garment = '/garment';
  static const createGarment = '/createGarment';
  static const editGarment = '/editGarment';
  

  // measurement

  static const measurement = '/measurement';
  static const createMeasurement = '/createMeasurement';
  static const editMeasurement = '/editMeasurement';

   // measurement

  static const accessory = '/accessory';
  static const createAccessory= '/createAccessory';
  static const editAccessory = '/editAccessory';

  static const garmentInfo = '/garmentInfo';

  static List siderbarMenuItems = [
    dashboard, media, categories, brands, banners, customers, orders, ordersDetail, material, garment, measurement, accessory
  ];
}
