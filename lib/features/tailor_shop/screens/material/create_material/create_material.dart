import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/material/create_material/responsive_screens/create_material_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/create_material/responsive_screens/create_material_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/create_material/responsive_screens/create_material_tablet.dart';

class CreateMaterialScreen extends StatelessWidget {
  const CreateMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ITSiteLayoutTemplate(desktop: CreateMaterialDesktopScreen(), tablet: CreateMaterialTabletScreen(), mobile: CreateMaterialMobileScreen(),);
  }
}