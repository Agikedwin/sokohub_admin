import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/persionalizations/screen/settings/responsive_screens/settings_desktop.dart';
import 'package:sokohub_admin/features/persionalizations/screen/settings/responsive_screens/settings_mobile.dart';
import 'package:sokohub_admin/features/persionalizations/screen/settings/responsive_screens/settings_tablet.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
     
    return const ITSiteLayoutTemplate(desktop: SettingsDesktopScreen(), tablet: SettingsTabletScreen(), mobile: SettingsMobileScreen(),);
  }
}