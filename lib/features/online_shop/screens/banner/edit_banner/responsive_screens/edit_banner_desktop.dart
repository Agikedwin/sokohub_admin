import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/features/online_shop/models/banner_model.dart';
import 'package:sokohub_admin/features/online_shop/models/brand_model.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:sokohub_admin/features/online_shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class EditBannerDesktopScreen extends StatelessWidget {
  const EditBannerDesktopScreen({super.key, required this.banner});
 
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true, heading: 'Update Banner', breadcrumbItems: [ITRoutes.banners, 'Update Banner']),
              SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditBannerForm(banner: BannerModel(name: '', imageUrl: 'imageUrl', active: true, targetScreen: 'targetScreen'),)
              

              

            ],
          ),
        ),
      ),
    );
  }
}