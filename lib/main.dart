import 'dart:math';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

int entryPars(String exp) {
  int sum = 0;
  final pluses = exp.split('+');
  List<int> plusOps = [];
  for (final item in pluses) {
    if (item.contains('-')) {
      final minusOperands =
          int.tryParse(item.split('-')[0])! - int.tryParse(item.split('-')[1])!;
      plusOps.add(minusOperands);
    } else {
      plusOps.add(int.tryParse(item)!);
    }
  }
  for (final item in plusOps) {
    sum = sum + item;
  }
  return sum;
}

void main() async {
  print(pow(2, 3));
  print(entryPars('1+2-3+5-45'));
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
