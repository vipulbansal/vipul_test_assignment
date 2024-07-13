import 'package:flutter/material.dart';
import 'package:vipul_test_assignment/vipul_assignment_app.dart';
import 'package:vipul_test_assignment/wrappers/service_locators.dart';

import 'commons/helpers/theme_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerLocatorsBag();

  runApp(const VipulAssignmentApp());
}
