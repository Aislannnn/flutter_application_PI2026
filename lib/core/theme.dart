import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme({
  required bool escuro,
  required double escalaFonte,
  required String tipoFonte,
}) {
  TextTheme base = ThemeData.light().textTheme;
  if (tipoFonte == 'Serif') {
    base = GoogleFonts.merriweatherTextTheme(base);
  } else if (tipoFonte == 'Mono') {
    base = GoogleFonts.sourceCodeProTextTheme(base);
  }

  return ThemeData(
    brightness: escuro ? Brightness.dark : Brightness.light,
    colorSchemeSeed: const Color(0xFF1848B0),
    textTheme: base.apply(fontSizeFactor: escalaFonte),
  );
}

SystemUiOverlayStyle buildAppOverlayStyle(bool escuro) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: escuro ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
}
