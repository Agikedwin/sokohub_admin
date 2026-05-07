import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/login_template.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/widgets/reset_header_and_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';

class ForgetPasswordMobileScreen extends StatelessWidget {
  const ForgetPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: ResetHeaderAndForm(),
        ),
      ),
    );
}
}