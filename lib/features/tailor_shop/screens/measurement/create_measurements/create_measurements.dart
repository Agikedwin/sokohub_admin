import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/measurement/create_measurements/responsive_screens/create_measurements_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/create_measurements/responsive_screens/create_measurements_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/create_measurements/responsive_screens/create_measurements_tablet.dart';


class CreateMeasurementScreen extends StatelessWidget {
  const CreateMeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateMeasurementDesktopScreen(), tablet: CreateMeasurementTabletScreen(), mobile: CreateMeasurementMobileScreen(),);
  }
}