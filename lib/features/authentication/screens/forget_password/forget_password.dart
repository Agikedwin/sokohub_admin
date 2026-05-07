import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ITSiteLayoutTemplate(uselayout: false, desktop: ForgetPasswordDesktopTabletScreen(), mobile: ForgetPasswordMobileScreen(),);
  }
}