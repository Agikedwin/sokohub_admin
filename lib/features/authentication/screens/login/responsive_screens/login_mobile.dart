import 'package:flutter/material.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_header.dart';
import 'package:sokohub_admin/utils/constants/sizes.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
               ITLoginHeader(),
                // Login Form
                LoginForm()
            ],
          ),
        ),
        

      ),
    );
  }
}