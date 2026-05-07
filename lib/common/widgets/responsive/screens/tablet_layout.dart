
import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/headers/header.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/sidebar.dart';

class ITTabletLayout extends StatelessWidget {
   ITTabletLayout({super.key, this.body});

 final Widget? body;
 final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      drawer: ITSidebar(),
      appBar: ITHeader(scaffoldKey: scaffoldKey,),
      body: body ?? const SizedBox()
    );
  }
}