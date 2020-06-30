/// References
/// https://flutter.dev/docs/development/accessibility-and-localization/internationalization
/// https://github.com/flutter/gallery/blob/master/lib/l10n/gallery_localizations.dart
/// Translations
/// https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification
/// https://www.codeandweb.com/babeledit/tutorials/how-to-translate-your-flutter-apps

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localisations_de.dart' deferred as localisations_de;
import 'localisations_en.dart' deferred as localisations_en;
import 'localisations_es.dart' deferred as localisations_es;

/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the GalleryLocalizations.supportedLocales
/// property.



abstract class Localisations {

  Localisations(String locale) 
    : assert(locale != null),
      localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Localisations of(BuildContext context) {
    return Localizations.of<Localisations>(
      context, 
      Localisations
    );
  }      

  static const LocalizationsDelegate<Localisations> delegate = _LocalisationsDelegate();

  /// A list of this localisations delegate along with the default localisations
  /// delegates.
  ///
  /// Returns a list of localisations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localisations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en', 'GB'),
    Locale('en', 'US'),
    Locale('de'),
    Locale('es')
  ];

  // Header title on home page.
  String get homeHeader;

  String get dashboardTitle;

  String get communityTitle;

  String get settingsTitle;

  String get settingsLocale;

  // Option label to indicate the system default will be used.
  String get settingsSystemDefault;  

  // Title for platform mechanics (iOS, Android, macOS, etc.) setting.
  String get settingsPlatform;  

  // Title for the theme setting.
  String get settingsTheme;

  // Title for the dark theme setting.
  String get settingsDarkTheme;

  // Title for the light theme setting.
  String get settingsLightTheme;

}

class _LocalisationsDelegate extends LocalizationsDelegate<Localisations> {

  const _LocalisationsDelegate();

  @override
  Future<Localisations> load(Locale locale) {
    return _lookupLocalisations(locale);
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es'
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_LocalisationsDelegate old) => false;

}

Future<Localisations> _loadLibrary(
  Future<dynamic> Function() loadLibrary,
  Localisations Function() localizationClosure) {

  /// Lazy load the library for web, 
  /// on other platforms we return the localizations synchronously.
  if (kIsWeb) {
    return loadLibrary().then((dynamic _) => localizationClosure());
  } else {
    return SynchronousFuture<Localisations>(localizationClosure());
  }

}

Future<Localisations> _lookupLocalisations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {

    case 'en':
    {
      switch (locale.countryCode) {

        case 'GB':
          return _loadLibrary(
            localisations_en.loadLibrary, 
            () => localisations_en.LocalisationsEn()
          );        

        case 'US':
          return _loadLibrary(
            localisations_en.loadLibrary, 
            () => localisations_en.LocalisationsEnUS()
          );          

      }
      break;
    }

  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {

    case 'de':
      return _loadLibrary(
        localisations_de.loadLibrary, 
        () => localisations_de.LocalisationsDe()
      );         

    case 'en':
      return _loadLibrary(
        localisations_en.loadLibrary, 
        () => localisations_en.LocalisationsEn()
      );      

    case 'es':
      return _loadLibrary(
        localisations_es.loadLibrary, 
        () => localisations_es.LocalisationsEs()
      );                    

  }

  assert(false, '_lookupLocalisations failed to load unsupported locale "$locale"');

  return null;

}