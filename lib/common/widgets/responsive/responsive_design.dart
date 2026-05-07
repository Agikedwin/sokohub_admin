import 'package:flutter/material.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ITResponsiveDesign extends StatelessWidget {
  const ITResponsiveDesign({super.key, required this.destop, required this.tablet, required this.mobile});

  /// Widget for destop layout
  
  final Widget destop;
  /// Widget for tablet layout
  
   final Widget tablet;
  /// Widget for mobile layout 
   final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, contraints){
        if(contraints.maxWidth >= TSizes.desktopScreenSize){
          return destop;
        }else if(contraints.maxWidth < TSizes.desktopScreenSize && contraints.maxWidth >= TSizes.tabletScreenSize){
          return tablet;
        }else{
          return mobile;
        }
        
        
      }
    );
  }
}