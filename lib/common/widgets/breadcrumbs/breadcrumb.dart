
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class TBreadcrumb extends StatelessWidget {
  const TBreadcrumb({super.key});

  // The heading for the page
  //List the breadscrumb utems representing the navigation path
  // Flag indicating whether to include a btton to return to the previous screen


  @override
  Widget build(BuildContext context) {
    return Column(
      /* crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(ITRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xl),
                child: Text('Dashboard',
                style:  Theme.of(context).textTheme.bodySmall!.apply(fontSizeDelta: -1),),
              ),
            ),
          ],
        ),

        SizedBox(height: TSizes.sm,),

        // Heading of the page

      ], */
    );
  }
}