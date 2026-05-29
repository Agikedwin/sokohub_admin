import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/site_layout.dart';

import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/responsive_screens/edit_category_desktop.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/responsive_screens/edit_category_mobile.dart';
import 'package:sokohub_admin/features/tailor_shop/screens/material/edit_material/responsive_screens/edit_category_tablet.dart';

class EditMaterialScreen extends StatelessWidget {
  const EditMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final material = Get.arguments;
    return  ITSiteLayoutTemplate(

      desktop: EditMaterialDesktopScreen(material: material ,),
      tablet: EditMaterialTabletScreen(material: material ),
      mobile: EditMaterialMobileScreen(material: material ),
    );
  }
}
