import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/attributes_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/product_type_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/stock_pricing_widget.dart';
import 'package:sokohub_admin/features/online_shop/screens/product/create_product/widgets/variation_widget.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
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
                                    
                                    
                        //  Variations
                        const ProductVariations()
                                    
                      ],
                    ),
                  ),
                  // Sidebar
                  SizedBox(height: TSizes.spaceBtwSections ),
                                    
                  // Product Image
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall,),
                        SizedBox(height: TSizes.spaceBtwItems ),
                        //ProductAdditionalImages()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections ),
                                    
                  // Product Brand
                  SizedBox(height: TSizes.spaceBtwSections ),
                                    
                  // Product Categories
                  //const ProductCategories()
                  SizedBox(height: TSizes.spaceBtwSections ),
                                    
                  // Product Visibility
                  //const ProductVisibilityWidget()
                  SizedBox(height: TSizes.spaceBtwSections )
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
}
}