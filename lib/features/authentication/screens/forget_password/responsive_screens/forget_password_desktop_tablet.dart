import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/templates/login_template.dart';
import 'package:sokohub_admin/features/authentication/screens/forget_password/widgets/reset_header_and_form.dart';



class ForgetPasswordDesktopTabletScreen extends StatelessWidget {
  const ForgetPasswordDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ITLoginTemplate(
      child: ResetHeaderAndForm(),
         
    );
}
}

