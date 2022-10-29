import 'package:flutter/material.dart';

class MyColor {
  static Color redDark = const Color(0xFF740707);
  static Color red = const Color(0xFFF44336);
  static Color green = const Color(0xff00ab55);
  static Color yellow = const Color(0xFFFFC107);
  static Color orange = const Color(0xFFFF6D00);
  static Color grey = const Color(0xFFBED6FE);
  static Color white = const Color(0xFFFFFFFF);

  static Color primary = const Color(0xFF50DC50);
  static Color light = const Color(0xffadffad);

  static Color container = const Color(0xFF1A3140);
  static Color pBackground = const Color(0xff0E1B26);
  static Color disabled = const Color(0xFF6D99B6);

  static Color pShadow = const Color(0xff34BF65);
  static Color pLight = const Color(0xff2EA662);
  static Color pBackgroundDark = const Color(0xff08151D);

  static Color transparent = const Color(0x00FFFFFF);
  static Color highlight = const Color(0xFF1C3647);
  static Color basecolor = const Color(0xFF132836);

  static Color blueContainer = const Color(0xFF182435);
  static Color blueBackground = const Color(0xFF0d101b);
}

MaterialColor generateMColor(Color color) {
  return MaterialColor(color.value, {
    50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
    100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
    200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
    300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
    400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
    500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
    600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
    700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
    800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
  });
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}

Color getColor(Set<MaterialState> states,
    {required Color activeColor, required Color inactiveColor}) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return activeColor;
  }
  return inactiveColor;
}
