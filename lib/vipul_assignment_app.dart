import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VipulAssignmentApp extends StatelessWidget {
  const VipulAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return const MaterialApp();
  }
}
