import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/login_template.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_form.dart';
import 'package:sokohub_admin/features/authentication/screens/login/widgets/login_header.dart';


class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ITLoginTemplate(
      child: Column(
        
              children: [
                // Header
                ITLoginHeader(),
                // Login Form
                LoginForm()

              ],
            ),
         
    );
  }
}

