import 'dart:async';

import 'package:flutter/material.dart';

class ThemeHelper {
  final _themeController = StreamController<ThemeMode>();

  Stream<ThemeMode> get themeStream => _themeController.stream;

  void changeTheme(ThemeMode mode) {
    _themeController.sink.add(mode);
  }

  void dispose() {
    _themeController.close();
  }
}