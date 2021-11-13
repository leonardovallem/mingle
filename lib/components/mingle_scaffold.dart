import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'action_bar.dart';

class MingleScaffold extends StatelessWidget {
  Widget? body;
  bool? hideActionBar;
  String? title;

  MingleScaffold({this.body, this.hideActionBar, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: title == null ? null : Text(title!),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        foregroundColor: const Color(0xFF69515D),
      ),
      body: body,
      bottomNavigationBar: hideActionBar == null || !hideActionBar! ? ActionBar() : null,
    );
  }
}
