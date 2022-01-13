import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/config/app_colors.dart';

setDeviceOrientationUp() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
}

setStatusBarColorTransparent() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.transparentColor,
      // navigation bar color
      statusBarColor: AppColors.transparentColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarDividerColor: AppColors.transparentColor,
      systemNavigationBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false
      // status bar color
      ));
}
