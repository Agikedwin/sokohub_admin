import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/edit_measurements/responsive_screens/edit_garment_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/edit_measurements/responsive_screens/edit_measurements_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/measurement/edit_measurements/responsive_screens/edit_measurements_tablet.dart';




class EditMeasurementScreen extends StatelessWidget {
  const EditMeasurementScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final measurement = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditMeasurementDesktopScreen(measurement: measurement ,),
      tablet: EditMeasurementTabletScreen(measurement: measurement ),
      mobile: EditMeasurementMobileScreen(measurement: measurement ),
    );
  }
}
