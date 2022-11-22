/*
 *  theme.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 15.12.2021.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/extensions/slider_track_shape.dart';

class AppTheme {
  // Primary colors in ARGB format.
  static const headerColor = Color(0xFFFFFFFF);
  static const foregroundColor = Color(0xFF000000);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const accentColor = Color(0xFFDF47D7);

  // Constants for detailed customization.
  static const appBarColor = headerColor;
  static const appBarTextColor = foregroundColor;
  static const appBarElevation = 4.0;

  static const artistTextColor = foregroundColor;
  static final trackTextColor = foregroundColor.withOpacity(0.25);

  static const controlButtonColor = accentColor;
  static const controlButtonSplashColor = Color(0xFFE91E63);
  static const controlButtonIconColor = backgroundColor;

  static const volumeSliderActiveColor = accentColor;
  static final volumeSliderOverlayColor = accentColor.withOpacity(0.12);
  static final volumeSliderInactiveColor = foregroundColor.withOpacity(0.05);

  static const drawerHeaderColor = headerColor;
  static const drawerBackgroundColor = backgroundColor;
  static const drawerTitleColor = foregroundColor;
  static final drawerDescriptionColor = foregroundColor.withOpacity(0.25);
  static const drawerIconColor = backgroundColor;
  static const drawerTextColor = foregroundColor;

  static const artworkShadowColor = Color(0x30000000);
  static const artworkShadowOffset = Offset(2.0, 2.0);
  static const artworkShadowRadius = 8.0;

  static const aboutUsTitleColor = foregroundColor;
  static final aboutUsDescriptionColor = foregroundColor.withOpacity(0.25);
  static final aboutUsTextColor = foregroundColor.withOpacity(0.9);
  static const aboutUsContainerTitleColor = Color(0xFF019EF6);
  static const aboutUsContainerBackgroundColor = headerColor;

  static const timerColor = foregroundColor;
  static const timerButtonTextColor = foregroundColor;
  static const timerButtonBackgroundColor = Color(0xFF2196F3);
  static const timerStopButtonTextColor = foregroundColor;
  static const timerStopButtonBackgroundColor = Color(0xFF9E9E9E);
  static const timerSliderColor = Color(0xFF2196F3);
  static const timerSliderTrackColor = Color(0xFFBBDEFB);
  static const timerSliderDotColor = foregroundColor;
  static const timerSliderTextColor = foregroundColor;

  // Don't edit this constant.
  static final themeData = ThemeData(
    canvasColor: backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
    ),
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: foregroundColor),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: appBarElevation,
      backgroundColor: appBarColor,
      foregroundColor: appBarTextColor,
    ),
    sliderTheme: SliderThemeData(
      trackShape: RoundSliderTrackShape(),
      activeTrackColor: volumeSliderActiveColor,
      thumbColor: volumeSliderActiveColor,
      overlayColor: volumeSliderOverlayColor,
      inactiveTrackColor: volumeSliderInactiveColor,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: drawerIconColor,
      textColor: drawerTextColor,
    ),
  );
}
