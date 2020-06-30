import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:investigation/models/settings.dart';
import 'package:investigation/locale/localisations.dart';
import 'package:investigation/themes/theme_data.dart';
import 'package:investigation/services/user_service.dart';
import 'package:investigation/pages/home.dart';

/// Investigation App
class InvestigationApp extends StatelessWidget {

  /// ctr
  const InvestigationApp({
    Key key
  }) : super(key: key);

  /// methods

  /// define list of providers
  List<SingleChildWidget> providers(BuildContext context) {

    return [
      // App Settings (locale, platform, theme)
      ChangeNotifierProvider<SettingsModel>(
        create: (context) => SettingsModel()
      ),
      // User Service
      Provider(
        create: (_) => UserService.create(),
        dispose: (_, UserService service) => service.client.dispose(),
      )
    ];

  }  

  // widget that wraps the application in a consumer for the settings provider
  Widget app(BuildContext context) {

    return Consumer<SettingsModel>(builder: (context, model, child) {
      return MaterialApp(
        title: 'Investigation',
        debugShowCheckedModeBanner: false,        
        // themes
        themeMode: model.currentModel.themeMode,
        theme: AppThemeData.lightThemeData.copyWith(
          platform: model.currentModel.platform
        ),
        darkTheme: AppThemeData.darkThemeData.copyWith(
          platform: model.currentModel.platform
        ),
        // localisations
        localizationsDelegates: const [
          ...Localisations.localizationsDelegates,
          LocaleNamesLocalizationsDelegate()
        ],
        supportedLocales: Localisations.supportedLocales,
        locale: model.currentModel.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          deviceLocale = locale;
          return locale;
        },          
        home: HomePage(),
        /// routing
        // initialRoute: HomePage.route,
        // routes: {
        //   HomePage.route: (context) => HomePage(),
        //   // UserListPage.route: (context) => UserListPage(),
        //   // CameraPage.route: (context) => CameraPage(availableDeviceCameras: availableDeviceCameras),
        //   // SettingsPage.route: (context) => SettingsPage(),
        // },
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: providers(context),
      child: app(context) 
    );

  }
}