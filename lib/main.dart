import 'dart:math';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

int parsExp(String experession) {
  final plusExp = RegExp(r'\+\d+');
  final minusExp = RegExp(r'-\d+');
  final normalNum = RegExp(r'\d+');
  final pluses = plusExp.allMatches(experession);
  final minuses = minusExp.allMatches(experession);
  final first = int.tryParse(normalNum.firstMatch(experession)![0]!);
  final plusSum = pluses
      .map((e) => int.tryParse(e[0]!))
      .reduce((value, element) => value! + element!);
  final minusSum = minuses
      .map((e) => int.tryParse(e[0]!))
      .reduce((value, element) => value! + element!);
  return plusSum! + first! + minusSum!;
}

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
  print(parsExp('1+2+14-2-4'));
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
