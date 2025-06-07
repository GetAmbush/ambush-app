import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ambush_app/src/core/settings/theme/text_theme.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'custom_color.dart';

extension TextStyleMapping on TextStyle {
  TextStyle onPrimary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onPrimary);
  }

  TextStyle onSecondary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSecondary);
  }

  TextStyle onTertiary(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onTertiary);
  }

  TextStyle onPrimaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);
  }

  TextStyle onSecondaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer);
  }

  TextStyle onTertiaryContainer(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer);
  }

  TextStyle onSurface(BuildContext context) {
    return copyWith(color: Theme.of(context).colorScheme.onSurface);
  }
}

extension ColorText on BuildContext {
  Color get onPrimary {
    return Theme.of(this).colorScheme.onPrimary;
  }

  Color get onPrimaryContainer {
    return Theme.of(this).colorScheme.onPrimaryContainer;
  }

  Color get onSecondary {
    return Theme.of(this).colorScheme.onSecondary;
  }

  Color get onSecondaryContainer {
    return Theme.of(this).colorScheme.onSecondaryContainer;
  }

  Color get onTertiary {
    return Theme.of(this).colorScheme.onTertiary;
  }

  Color get onTertiaryContainer {
    return Theme.of(this).colorScheme.onTertiaryContainer;
  }
}

extension CorePaletteMapping on CorePalette {
  ColorScheme get colorScheme {
    return ColorScheme.light(
      primary: Color(primary.get(40)),
      onPrimary: Color(primary.get(100)),
      primaryContainer: Color(primary.get(90)),
      onPrimaryContainer: Color(primary.get(10)),
      secondary: Color(secondary.get(40)),
      onSecondary: Color(secondary.get(100)),
      secondaryContainer: Color(secondary.get(90)),
      onSecondaryContainer: Color(secondary.get(10)),
      tertiary: Color(tertiary.get(40)),
      onTertiary: Color(tertiary.get(100)),
      tertiaryContainer: Color(tertiary.get(90)),
      onTertiaryContainer: Color(tertiary.get(10)),
      error: Color(error.get(40)),
      onError: Color(error.get(100)),
      errorContainer: Color(error.get(90)),
      onErrorContainer: Color(error.get(10)),
      surface: Color(neutral.get(99)),
      onSurface: Color(neutral.get(10)),
      surfaceContainerHighest: Color(neutralVariant.get(90)),
      onSurfaceVariant: Color(neutralVariant.get(30)),
      outline: Color(neutralVariant.get(50)),
      shadow: Color(neutral.get(0)),
      inverseSurface: Color(neutral.get(20)),
      onInverseSurface: Color(neutral.get(95)),
      inversePrimary: Color(primary.get(80)),
    );
  }

  ColorScheme get darkColorScheme {
    return ColorScheme.dark(
      primary: Color(primary.get(80)),
      onPrimary: Color(primary.get(20)),
      primaryContainer: Color(primary.get(30)),
      onPrimaryContainer: Color(primary.get(90)),
      secondary: Color(secondary.get(80)),
      onSecondary: Color(secondary.get(20)),
      secondaryContainer: Color(secondary.get(30)),
      onSecondaryContainer: Color(secondary.get(90)),
      tertiary: Color(tertiary.get(80)),
      onTertiary: Color(tertiary.get(20)),
      tertiaryContainer: Color(tertiary.get(30)),
      onTertiaryContainer: Color(tertiary.get(90)),
      error: Color(error.get(80)),
      onError: Color(error.get(20)),
      errorContainer: Color(error.get(30)),
      onErrorContainer: Color(error.get(80)),
      surface: Color(neutral.get(10)),
      onSurface: Color(neutral.get(90)),
      surfaceContainerHighest: Color(neutralVariant.get(30)),
      onSurfaceVariant: Color(neutralVariant.get(80)),
      outline: Color(neutralVariant.get(60)),
      shadow: Color(neutral.get(0)),
      inverseSurface: Color(neutral.get(90)),
      onInverseSurface: Color(neutral.get(20)),
      inversePrimary: Color(primary.get(40)),
    );
  }
}

InputDecorationTheme get inputDecorationTheme {
  return InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    filled: true,
  );
}

FloatingActionButtonThemeData floatingActionButton(ColorScheme colorScheme) {
  return FloatingActionButtonThemeData(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
  );
}

AppBarTheme appBarThemeLight(ColorScheme colorScheme) {
  return AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

AppBarTheme appBarThemeDark(ColorScheme colorScheme) {
  return AppBarTheme(
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

DialogThemeData get dialogTheme {
  return DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}

TimePickerThemeData get timePickerTheme {
  return TimePickerThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    hourMinuteShape: const CircleBorder(),
  );
}

extension ColorExtension on Color {
  /// Convert the color to a darkened color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final factor = 1 - percent / 100;

    return Color.fromARGB(
      (a * 255).round(),
      (r * factor * 255).round(),
      (g * factor * 255).round(),
      (b * factor * 255).round(),
    );
  }
}

CustomColors lightCustomColor = CustomColors(
  red: Colors.red.shade400,
  green: Colors.green.shade400,
);
CustomColors darkCustomColor = CustomColors(
  red: Colors.red.shade400,
  green: Colors.green.shade400,
);

ThemeData getLightTheme(ColorScheme lightColorScheme, BuildContext context) {
  return ThemeData.from(
    colorScheme: lightColorScheme,
  ).copyWith(
    colorScheme: lightColorScheme,
    dialogTheme: dialogTheme.copyWith(
      backgroundColor: lightColorScheme.surface,
    ),
    timePickerTheme: timePickerTheme,
    appBarTheme: appBarThemeLight(lightColorScheme),
    textTheme: getTextTheme(false),
    scaffoldBackgroundColor: lightColorScheme.surface,
    applyElevationOverlayColor: true,
    inputDecorationTheme: inputDecorationTheme,
    extensions: [lightCustomColor],
    dividerTheme: DividerThemeData(
      color: ThemeData.light().dividerColor,
    ),
  );
}

ThemeData getDarkTheme(ColorScheme darkColorScheme, BuildContext context) {
  return ThemeData.from(
    colorScheme: darkColorScheme,
  ).copyWith(
    colorScheme: darkColorScheme,
    dialogTheme: dialogTheme.copyWith(
      backgroundColor: darkColorScheme.surface
    ),
    timePickerTheme: timePickerTheme,
    appBarTheme: appBarThemeDark(darkColorScheme),
    textTheme: getTextTheme(true),
    scaffoldBackgroundColor: darkColorScheme.surface,
    applyElevationOverlayColor: true,
    inputDecorationTheme: inputDecorationTheme,
    extensions: [darkCustomColor],
    dividerTheme: DividerThemeData(
      color: ThemeData.dark().dividerColor,
    ),
  );
}
