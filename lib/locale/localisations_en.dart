
//import 'package:intl/intl.dart' as intl;
import 'localisations.dart';

/// The translations for English (`en`).
class LocalisationsEn extends Localisations {

  LocalisationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeHeader => 'Investigations';

  @override
  String get communityTitle => 'Community';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLocale => 'Locale';

  @override
  String get settingsPlatform => 'Platform';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsDarkTheme => 'Dark';

  @override
  String get settingsLightTheme => 'Light';

  @override
  String get settingsSystemDefault => 'System';

}

/// The translations for English, as used in US (`en_US`).
class LocalisationsEnUS extends LocalisationsEn {

  LocalisationsEnUS() : super('en-US');

}

