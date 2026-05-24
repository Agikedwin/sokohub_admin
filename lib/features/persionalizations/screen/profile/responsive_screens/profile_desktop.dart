import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sokohub_admin/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/data_table/table_header.dart';
import 'package:sokohub_admin/features/online_shop/screens/banner/all_banners/table/data_table.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/widgets/image_meta.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/widgets/profile_form.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: false, heading: 'Profile', breadcrumbItems: ['Profile']),
              SizedBox(height: TSizes.spaceBtwSections,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(
                    child: ImageMeta()),

                     SizedBox(width: TSizes.spaceBtwSections / 2,),

                    // Form
                    Expanded( flex: 2, child:  ProfileForm())

                  
                ],
              )

              

            ],
          ),
        ),
      ),
    );
  }
}