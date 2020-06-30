
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'package:investigation/models/settings.dart';
import 'package:investigation/locale/localisations.dart';

class SettingsPage extends StatefulWidget {

  static const String route = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  DisplayOption _getLocaleDisplayOption(BuildContext context, Locale locale) {

    final localeCode = locale.toString();
    final localeName = LocaleNames.of(context).nameOf(localeCode);

    if (localeName != null) {

      final localeNativeName = LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeCode];
      
      return localeNativeName != null ? DisplayOption(localeNativeName, subtitle: localeName) : DisplayOption(localeName);

    }

    return DisplayOption(localeCode);
  }

  LinkedHashMap<Locale, DisplayOption> _getLocaleOptions() {

    var localeOptions = LinkedHashMap.of({
      systemLocaleOption: DisplayOption(
        Localisations.of(context).settingsSystemDefault + (deviceLocale != null ? ' - ${_getLocaleDisplayOption(context, deviceLocale).title}' : '')
      ),
    });

    var supportedLocales = List<Locale>.from(Localisations.supportedLocales);
    supportedLocales.removeWhere((locale) => locale == deviceLocale);

    final displayLocales = Map<Locale, DisplayOption>.fromIterable(
      supportedLocales,
      value: (dynamic locale) => _getLocaleDisplayOption(context, locale as Locale)
    ).entries.toList()
      ..sort((l1, l2) => compareAsciiUpperCase(l1.value.title, l2.value.title));

    localeOptions.addAll(LinkedHashMap.fromEntries(displayLocales));

    return localeOptions;    
  }

  @override
  Widget build(BuildContext context) {

    var settings = Provider.of<SettingsModel>(context);
    Settings currentSettings = settings.currentModel;

    final settingsListItems = [
      SettingsListItem<Locale>(
        title: Localisations.of(context).settingsLocale,
        selectedOption: currentSettings.locale == deviceLocale
            ? systemLocaleOption
            : currentSettings.locale,
        options: _getLocaleOptions(),
        onOptionChanged: (newLocale) {

          if (newLocale == systemLocaleOption) {
            newLocale = deviceLocale;
          }

          // apply locale change
          settings.updateModel(currentSettings.copyWith(locale: newLocale));
        },
      ),
      SettingsListItem<TargetPlatform>(
        title: Localisations.of(context).settingsPlatform,
        selectedOption: currentSettings.platform,
        options: LinkedHashMap.of({
          TargetPlatform.android: DisplayOption('Android'),
          TargetPlatform.iOS: DisplayOption('iOS')
        }),
        onOptionChanged: (newPlatform) => settings.updateModel(
          currentSettings.copyWith(platform: newPlatform)
        ),
      ),
      SettingsListItem<ThemeMode>(
        title: Localisations.of(context).settingsTheme,
        selectedOption: currentSettings.themeMode,
        options: LinkedHashMap.of({
          ThemeMode.system: DisplayOption(
            Localisations.of(context).settingsSystemDefault,
          ),
          ThemeMode.dark: DisplayOption(
            Localisations.of(context).settingsDarkTheme,
          ),
          ThemeMode.light: DisplayOption(
            Localisations.of(context).settingsLightTheme,
          )
        }),
        onOptionChanged: (newThemeMode) => settings.updateModel(
          currentSettings.copyWith(themeMode: newThemeMode)
        ),
      ),
    ];

    return Material(
      child: ListView(
        children: [
          ...settingsListItems  
        ],
      ),
    );

  }  

}

class SettingsListItem<T> extends StatefulWidget {

  SettingsListItem({
    Key key,
    @required this.title,
    @required this.options,
    @required this.selectedOption,
    @required this.onOptionChanged,
  }) : super(key: key);  

  final String title;
  final LinkedHashMap<T, DisplayOption> options;
  final T selectedOption;
  final ValueChanged<T> onOptionChanged;

  @override
  _SettingsListItemState createState() => _SettingsListItemState<T>();

}

final settingItemBorderRadius = BorderRadius.zero;
const settingItemHeaderMargin = EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8);
const settingItemHeaderPadding = EdgeInsetsDirectional.fromSTEB(32, 18, 32, 20);

class _SettingsListItemState<T> extends State<SettingsListItem<T>> {

  Widget _buildHeaderWithChildren(BuildContext context, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CategoryHeader(
          margin: settingItemHeaderMargin,
          padding: settingItemHeaderPadding,
          borderRadius: settingItemBorderRadius,
          subtitleHeight: 5,
          title: widget.title,
          subtitle: widget.options[widget.selectedOption]?.title ?? '',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: ClipRect(
            child: Align(
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final optionWidgetsList = <Widget>[];    

    widget.options.forEach(
      (optionValue, optionDisplay) => optionWidgetsList.add(
        RadioListTile<T>(
          value: optionValue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                optionDisplay.title,
                style: theme.textTheme.bodyText1.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              if (optionDisplay.subtitle != null)
                Text(
                  optionDisplay.subtitle,
                  style: theme.textTheme.bodyText1.copyWith(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.8),
                  ),
                ),
            ],            
          ),
          groupValue: widget.selectedOption,
          onChanged: (newOption) => widget.onOptionChanged(newOption),
          activeColor: Theme.of(context).colorScheme.primary,
          dense: true,          
        )
      )
    );

    return Builder(
      builder: (context) => _buildHeaderWithChildren(
        context, 
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, bottom: 40),
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(
                width: 2,
                color: theme.colorScheme.background,
              ),
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => optionWidgetsList[index],
            itemCount: optionWidgetsList.length,
          ),
        ),
      ),
    );

  }  

}

class DisplayOption {

  DisplayOption(this.title, {this.subtitle});

  final String title;
  final String subtitle;

}

class _CategoryHeader extends StatelessWidget {

  const _CategoryHeader({
    Key key,
    this.margin,
    this.padding,
    this.borderRadius,
    this.subtitleHeight,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final String title;
  final String subtitle;
  final double subtitleHeight;
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: margin,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: colorScheme.secondary,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.subtitle1.apply(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.overline.apply(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}