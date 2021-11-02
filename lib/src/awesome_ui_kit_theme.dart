import 'package:flutter/material.dart';

import 'awesome_ui_kit.dart';

class AwesomeUiKitTheme {
  static double get padding => AwesomeUiKit.instance.padding;
  static double get fontSize => AwesomeUiKit.instance.fontSize;
  static double get borderRadius => AwesomeUiKit.instance.borderRadius;

  static Duration get duration => AwesomeUiKit.instance.duration;
  static Duration get animationDuration =>
      AwesomeUiKit.instance.animationDuration;
  static Duration get snackbarDuration =>
      AwesomeUiKit.instance.snackbarDuration;

  static AwesomeUiKitTextTheme get textTheme => AwesomeUiKit.instance.textTheme;
  static AwesomeUiKitButtonSizes get buttonSizes =>
      AwesomeUiKit.instance.buttonSizes;
  static AwesomeUiKitStatusColors get statusColors =>
      AwesomeUiKit.instance.statusColors;
  static AwesomeUiKitSocialColors get socialColors =>
      AwesomeUiKit.instance.socialColors;

  static List<BoxShadow> generateBoxShadow(
    color, {
    double spreadRadius = 1,
    double blurRadius = 12,
    Offset offset = const Offset(0, 8),
  }) {
    return [
      BoxShadow(
        color: color,
        offset: offset, // changes position of shadow
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ];
  }
}
