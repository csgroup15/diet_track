import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

String getCurrentThemeMode(BuildContext ctx) {
  final themeMode = AdaptiveTheme.of(ctx).mode;

  switch (themeMode) {
    case AdaptiveThemeMode.light:
      return 'Light';
    case AdaptiveThemeMode.dark:
      return 'Dark';
    case AdaptiveThemeMode.system:
      return 'System';
    default:
      return '';
  }
}

String getCurrentTheme(BuildContext context) {
  final theme = Theme.of(context);
  return theme.brightness == Brightness.light ? 'light' : 'dark';
}
