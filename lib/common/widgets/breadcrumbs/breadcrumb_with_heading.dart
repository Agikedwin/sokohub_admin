import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/texts/page_heading.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class TBreadcrumbsWithHeading extends StatelessWidget {
  const TBreadcrumbsWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbItems,
      this.returnToPreviousScreen =false
      });

  // The heading for the page
  final String heading;
  //List the breadscrumb utems representing the navigation path
  final List<String> breadcrumbItems;
  // Flag indicating whether to include a btton to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(ITRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.sm /4),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontSizeDelta: -1),
                ),
              ),
            ),
            for (var i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'),
                  InkWell(
                    // Last item shpuld not be clickable
                    onTap: () => i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.sm /4),
                      //Format the breadcrumb item: capitalize and remove leading '/'
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontSizeDelta: -1),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),

        SizedBox(
          height: TSizes.sm,
        ),

        // Heading of the page
        Row(
          children: [
            if(returnToPreviousScreen) IconButton(onPressed: ()=> Get.back(), icon: Icon(Iconsax.arrow_left)),
             if(returnToPreviousScreen)  const SizedBox(width: TSizes.spaceBtwItems,),
             TPageHeading(heading: heading)

          ],
        )

      ],
    );
  }

  // Fuction to capita;ize the first letter of the string

  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
