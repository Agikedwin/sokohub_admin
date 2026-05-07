import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:sokohub_admin/features/authentication/screens/login/responsive_screens/login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(uselayout: false, desktop: LoginDesktopTabletScreen(), mobile: LoginMobileScreen(),);
  }
}