import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/additional_images.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/attributes_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/bottom_navigation_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/brand_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/categories_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/product_type_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/stock_pricing_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/thumbnail_image_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/title_description.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/variation_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/visibility_widget.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/device/device_utility.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      // bottomNavigationBar: const ProductBottomNagigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Create Product',
                  breadcrumbItems: [ITRoutes.products, 'Create Product']),

              SizedBox(height: TSizes.spaceBtwSections ),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      // Stock and Pricing
                      const ProductTitleDescription(),
                        SizedBox(height: TSizes.spaceBtwSections ),

                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Heading

                              Text('Stock and Pricing', style:  Theme.of(context).textTheme.headlineSmall,),
                              SizedBox(height: TSizes.spaceBtwItems ),

                              // Product Type

                               const ProductTypeWidget(),
                              SizedBox(height: TSizes.spaceBtwInputFields ),

                              // Stock
                             const ProoductStockAndPricingWidget(),
                              SizedBox(height: TSizes.spaceBtwSections ),

                              // Attributes
                               const ProductAttributesWidget(),
                              SizedBox(height: TSizes.spaceBtwSections ),


                             

                            ],
                          ),
                        ),
                          SizedBox(height: TSizes.spaceBtwSections /2 ),
                         //  Variations
                              const ProductVariations()
                     ],
                      
                    )
                    

                  ),
                  SizedBox(width:TSizes.defaultSpace),
                  // Sidebar
                  Expanded(
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Thumbnail
                         const ProductThumbnailImageWidget(),
                        SizedBox(height: TSizes.spaceBtwSections ),

                        // Product Image
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall,),

                             const SizedBox(height: TSizes.spaceBtwItems ),
                              ProductAdditionalImages(
                                additionalProductImagesURLs: RxList<String>.empty(),
                                onTapToAddImages: () {
                                  
                                },
                                onTapToRemoveImages: (index) {
                                  
                                },
                              )
                            ],
                          ),
                        ),

                        // Product Brand
                        SizedBox(height: TSizes.spaceBtwSections ),
                        const ProductBrand(),

                         SizedBox(height: TSizes.spaceBtwSections ),

                        // Product Categories
                        const ProductCategories(),
                        SizedBox(height: TSizes.spaceBtwSections ),

                        // Product Visibility
                        const ProductVisibilityWidget(),
                        SizedBox(height: TSizes.spaceBtwSections ),

                        ProductBottomNavigationWidget()
                      ],
                    ),
                  )
                ],
              )

              
            ],
          ),
        ),
      ),
    );
  }
  }
