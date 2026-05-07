import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/bindings/general_binding.dart';
import 'package:sokohub_admin/routes/app_routes.dart';
import 'package:sokohub_admin/routes/routes.dart';
import 'package:sokohub_admin/utils/constants/text_strings.dart';
import 'package:sokohub_admin/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    print('At the APP');
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      getPages: ITAppRoutes.pages,
      initialRoute: ITRoutes.login,
      initialBinding: GeneralBinding(),
      unknownRoute: GetPage(name: '/page-not-found', page: () => const Scaffold(body: Center(child: Text('Page Not Found'),),)),
      
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}