
//import 'package:intl/intl.dart' as intl;
import 'localisations.dart';

/// The translations for Spanish Castilian (`es`).
class LocalisationsEs extends Localisations {

  LocalisationsEs([String locale = 'es']) : super(locale);

  @override
  String get homeHeader => 'Investigaciones';

  @override
  String get communityTitle => 'Comunidad';

  @override
  String get dashboardTitle => 'Tablero';

  @override
  String get settingsTitle => 'Ajustes';  

  @override
  String get settingsLocale => 'Configuración regional';  

  @override
  String get settingsPlatform => 'Mecánica de la plataforma';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsDarkTheme => 'Oscuro';

  @override
  String get settingsLightTheme => 'Claro';

  @override
  String get settingsSystemDefault => 'Sistema';  

}

