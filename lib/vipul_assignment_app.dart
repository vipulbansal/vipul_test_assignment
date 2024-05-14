import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vipul_test_assignment/wrappers/dismiss_keyboard.dart';

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
    return DismissKeyboardWrapper(
      child: const MaterialApp(
        
      ),
    );
  }
}
