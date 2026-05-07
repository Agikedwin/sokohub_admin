import 'package:flutter/material.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sokohub_admin/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class ResetPasswordMobileScreen extends StatelessWidget {
  const ResetPasswordMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:ResetPasswordWidget(email: 'agikedwin@gmail.com')
        ),
        

      ),
    );
  }
}