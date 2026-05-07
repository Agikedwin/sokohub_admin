
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/headers/header.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/sidebar.dart';

class ITMobileLayout extends StatelessWidget {
   ITMobileLayout({super.key, this.body});

  final Widget? body;
 final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      drawer: const ITSidebar(),
      appBar:ITHeader(scaffoldKey: scaffoldKey,),
      body: body ?? const SizedBox()
    );
  }
}