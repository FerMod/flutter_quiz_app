import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import '../model_binding.dart';

Locale _deviceLocale;
Locale get deviceLocale => _deviceLocale;
set deviceLocale(Locale locale) => _deviceLocale ??= locale;

class AppOptions {
  const AppOptions({
    this.themeMode,
    Locale locale,
    this.platform,
  }) : _locale = locale;

  final ThemeMode themeMode;
  final TargetPlatform platform;
  final Locale _locale;

  Locale get locale => _locale ?? deviceLocale;

  SystemUiOverlayStyle resolvedSystemUiOverlayStyle() {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    return brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
  }

  AppOptions copyWith({
    ThemeMode themeMode,
    Locale locale,
    TargetPlatform platform,
  }) {
    return AppOptions(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      platform: platform ?? this.platform,
    );
  }

  static AppOptions of(BuildContext context) {
    return ModelBinding.of<AppOptions>(context);
  }

  static void update(BuildContext context, AppOptions newModel) {
    ModelBinding.update<AppOptions>(context, newModel);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final AppOptions otherModel = other;
    return otherModel.themeMode == themeMode && otherModel.platform == platform && otherModel.locale == locale;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => hashValues(
        themeMode,
        locale,
        platform,
      );
}
