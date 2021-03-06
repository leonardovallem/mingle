import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projects/components/cloud_card.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/landing_page.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Center(
            child: CloudCard(size: 320),
          ),
        ),
      ),
    );
  }
}
