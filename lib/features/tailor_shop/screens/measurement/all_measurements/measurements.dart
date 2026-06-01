import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/measurement/all_measurements/responsive_screens/measurements_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/all_measurements/responsive_screens/measurements_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/all_measurements/responsive_screens/measurements_tablet.dart';


class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: MeasurementDesktopScreen(), tablet: MeasurementTabletScreen(), mobile: MeasurementMobileScreen(),);
  }
}