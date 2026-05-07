import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/styles/spacing_styles.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ITLoginTemplate extends StatelessWidget {
  const ITLoginTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              color: TColors.white
            ),
            child: child
            ),
          ),
        ),
      );
    
  }
}