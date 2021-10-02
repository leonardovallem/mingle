import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'action_bar.dart';

class MingleScaffold extends StatelessWidget {
  Widget? body;
  bool? hideActionBar;

  MingleScaffold({this.body, this.hideActionBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        foregroundColor: Color(0xFF69515D),
      ),
      body: body,
      bottomNavigationBar: hideActionBar == null || !hideActionBar! ? ActionBar() : null,
    );
  }
}
