import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/containers/rounded_container.dart';
import 'package:sokohub_admin/common/widgets/icons/t_circular_icon.dart';
import 'package:sokohub_admin/common/widgets/texts/section_heading.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    this.onTap,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = TColors.success,
    required this.stats,
    required this.headingIcon,
    required this.headingIconColor,
    required this.headingIconBgColor,
  });

  final Function()? onTap;
  final String title, subTitle;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingIconBgColor;
  final int stats;


  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          // Heading
          Row(
            children: [
              TCircularIcon(
                icon: headingIcon,
                backgroundColor: headingIconBgColor,
                color: headingIconColor,
                size: TSizes.md,
              ),
              const SizedBox(width: TSizes.spaceBtwItems,),
              TSectionHeading(
            title: title,
            textColor: TColors.textSecondary,
          ),
            ],
          ),
          
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    /// Left Side
    Expanded(
      child: Text(
        subTitle,
        style: Theme.of(context).textTheme.headlineMedium,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    const SizedBox(width: TSizes.spaceBtwItems),

    /// Right Side
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        /// Indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: TSizes.iconSm,
            ),

            const SizedBox(width: 4),

            Text(
              '$stats%',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(
                    color: color,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        SizedBox(
          width: 135,
          child: Text(
            'Compare to Dec 2025',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  ],
)
        ],
      ),
    );
  }
}
