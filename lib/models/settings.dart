
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

// Fake locale to represent the system Locale option.
const systemLocaleOption = Locale('system');

Locale _deviceLocale;
Locale get deviceLocale => _deviceLocale;
set deviceLocale(Locale locale) {
  _deviceLocale ??= locale;
}

class Settings {

  /// ctr
  Settings({
    this.themeMode, 
    locale,
    this.platform 
  }) : _locale = locale;

  /// properties
  
  final ThemeMode themeMode;
  final Locale _locale;
  final TargetPlatform platform;

  /// methods

  Locale get locale => _locale ?? deviceLocale ?? const Locale('en', 'GB');

  Settings copyWith({
    ThemeMode themeMode, 
    Locale locale,
    TargetPlatform platform}) {

      return Settings(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this._locale,
        platform: platform ?? this.platform
      );

  }

  /// overrides

  @override
  bool operator ==(Object other) =>
    other is Settings &&
    themeMode == other.themeMode &&
    locale == other.locale &&
    platform == other.platform;

  @override
  int get hashCode => hashValues(
    themeMode,
    locale,
    platform
  );

}

class SettingsModel extends ChangeNotifier {

  Settings _currentModel;

  Settings get currentModel => _currentModel ?? Settings(themeMode: ThemeMode.system, platform: defaultTargetPlatform);

  void updateModel(Settings newModel) {

    assert(newModel != null);

    if (newModel != _currentModel) {

      _currentModel = newModel;

      // This call tells the widgets that are listening to this model to rebuild.
      notifyListeners();    
    }

  }

}