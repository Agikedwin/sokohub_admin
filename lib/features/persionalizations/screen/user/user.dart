import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/persionalizations/screen/user/responsive_screens/user_desktop.dart';
import 'package:sokohub_admin/features/persionalizations/screen/user/responsive_screens/user_mobile.dart';
import 'package:sokohub_admin/features/persionalizations/screen/user/responsive_screens/user_tablet.dart';



class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: UserDesktopScreen(), tablet: UserTabletScreen(), mobile: UserMobileScreen(),);
  }
}