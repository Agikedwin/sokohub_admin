import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:sokohub_admin/app.dart';
import 'package:sokohub_admin/data/repositories/authentication/authentication_repository.dart';
import 'package:sokohub_admin/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async{

  // Initialize Getx local storage

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize firebase authentication
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  .then((value) => Get.put(AuthenticationRepository()));
  print('At Main');

  runApp(const App());
}
