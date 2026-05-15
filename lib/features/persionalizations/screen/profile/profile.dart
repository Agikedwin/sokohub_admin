import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/persionalizations/screen/profile/responsive_screens/profile_desktop.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/responsive_screens/profile_mobile.dart';
import 'package:sokohub_admin/features/persionalizations/screen/profile/responsive_screens/profile_tablet.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: ProfileDesktopScreen(), tablet: ProfileTabletScreen(), mobile: ProfileMobileScreen(),);
  }
}