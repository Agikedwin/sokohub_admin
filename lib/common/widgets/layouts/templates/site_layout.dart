import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/responsive/responsive_design.dart';
import 'package:sokohub_admin/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:sokohub_admin/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:sokohub_admin/common/widgets/responsive/screens/tablet_layout.dart';

class ITSiteLayoutTemplate extends StatelessWidget {
  const ITSiteLayoutTemplate({super.key,  this.desktop,  this.tablet,  this.mobile, this.uselayout = true});


  /// Widget for destop layout
  
  final Widget? desktop;
  /// Widget for tablet layout
  
   final Widget? tablet;
  /// Widget for mobile layout 
   final Widget? mobile;

   /// Flag to determine whether to use the layout
   final bool uselayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ITResponsiveDesign(
        destop: uselayout ? ITDesktopLayout(body: desktop,) : desktop ?? Container(),
        tablet: uselayout ? ITTabletLayout(body: tablet ?? desktop,): tablet ?? desktop ?? Container(),
        mobile: uselayout ? ITMobileLayout(body: mobile ?? desktop,) : mobile ?? desktop ?? Container(),
      ),
    );
  }
}