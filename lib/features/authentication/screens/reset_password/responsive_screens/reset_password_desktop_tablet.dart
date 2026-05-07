import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/login_template.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/colors.dart';
import 'package:sokohub_admin/utils/constants/image_strings.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';


class ResetPasswordDesktopTabletScreen extends StatelessWidget {
  const ResetPasswordDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ITLoginTemplate(
      child: ResetPasswordWidget(email: 'agikedwin@gmail.com',),
         
    );
  }
}


