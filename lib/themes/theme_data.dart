
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {

  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static const Color _midnightBlue = Color(0xFF2D4760);
  static const Color _oceanBlue = Color(0xFF496DC2);
  static const Color _charcoalGrey = Color(0xFF34404E);
  static const Color _lightBlue = Color(0xFFC0D4FE);
  static const Color _metalGrey = Color(0xFF97A7B9);
  static const Color _lightGrey = Color(0xFFD9DFE6);
  static const Color _aluminiumGrey = Color(0xFFBEC6CD);
  static const Color _dustyGrey = Color(0xFFB7BCC1);  

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      cardTheme: CardTheme(color: colorScheme.secondaryVariant),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.secondary,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
      ),
    );  
  }

  /// Colour Themes
  
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: _midnightBlue,
    primaryVariant: _charcoalGrey,
    secondary: _oceanBlue,
    secondaryVariant: _metalGrey,
    background: _lightBlue,
    surface: _lightGrey,
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: _dustyGrey,
    onSurface: _aluminiumGrey,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF9AA0A6),
    primaryVariant: Color(0xFF9AA0A6), 
    secondary: Color(0xFF9AA0A6),
    secondaryVariant: Color(0xFF9AA0A6),
    background: Color(0xFF202124),
    surface: Color(0xFF202124),
    onBackground: Color(0xFF202124),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );  

  /// Text Theme

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.manrope(fontWeight: _bold, fontSize: 30),
    headline6: GoogleFonts.manrope(fontWeight: _semiBold, fontSize: 15),
    caption: GoogleFonts.manrope(fontWeight: _semiBold, fontSize: 14),
    subtitle1: GoogleFonts.manrope(fontWeight: _semiBold, fontSize: 14),
    bodyText1: GoogleFonts.manrope(fontWeight: _medium, fontSize: 14),
    bodyText2: GoogleFonts.manrope(fontWeight: _regular, fontSize: 14),
    button: GoogleFonts.manrope(fontWeight: _semiBold, fontSize: 15)
  );  

}