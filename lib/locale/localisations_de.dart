
//import 'package:intl/intl.dart' as intl;
import 'localisations.dart';

/// The translations for German (`de`).
class LocalisationsDe extends Localisations {

  LocalisationsDe([String locale = 'de']) : super(locale);

  @override
  String get homeHeader => 'Untersuchungen';

  @override
  String get communityTitle => 'Gemeinschaft';

  @override
  String get dashboardTitle => 'Instrumententafel';

  @override
  String get settingsTitle => 'Einstellungen';  

  @override
  String get settingsLocale => 'Sprache';

  @override
  String get settingsPlatform => 'Funktionsweise der Plattform';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsDarkTheme => 'Dunkel';

  @override
  String get settingsLightTheme => 'Hell';

  @override
  String get settingsSystemDefault => 'System';  

}

