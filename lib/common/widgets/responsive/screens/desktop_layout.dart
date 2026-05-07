import 'package:flutter/material.dart';
import 'package:sokohub_admin/common/widgets/layouts/headers/header.dart';
import 'package:sokohub_admin/common/widgets/layouts/sidebars/sidebar.dart';

class ITDesktopLayout extends StatelessWidget {
  const ITDesktopLayout({super.key, this.body});

  final Widget? body;  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Row(
        children: [
          Expanded(child: ITSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                ITHeader(),
                  ///BODY
                Expanded(child: body ?? const SizedBox()) 
              ],
            ),
            ),            
        ],
      ),
    );
  }
}