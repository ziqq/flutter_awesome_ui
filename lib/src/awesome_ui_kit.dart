import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum AwesomeUiKitSnackBarStatus { success, error }

class AwesomeUiKitStatusColors {
  Color success;
  Color error;
  Color warn;
  Color info;

  AwesomeUiKitStatusColors({
    required this.success,
    required this.error,
    required this.warn,
    required this.info,
  });
}

class AwesomeUiKitSocialColors {
  Color whatsapp;
  Color viber;
  Color vk;

  AwesomeUiKitSocialColors({
    required this.whatsapp,
    required this.viber,
    required this.vk,
  });
}

class AwesomeUiKitButtonSizes {
  double extraSmall;
  double small;
  double medium;
  double large;

  AwesomeUiKitButtonSizes({
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
  });
}

class AwesomeUiKitTextTheme {
  TextStyle? headline1;
  TextStyle? headline2;
  TextStyle? headline3;
  TextStyle? headline4;
  TextStyle? headline5;
  TextStyle? bodyText1;
  TextStyle? bodyText2;
  TextStyle? caption;

  AwesomeUiKitTextTheme({
    required this.headline1,
    required this.headline2,
    required this.headline3,
    required this.headline4,
    required this.headline5,
    required this.bodyText1,
    required this.bodyText2,
    required this.caption,
  });

  AwesomeUiKitTextTheme copyWith({
    TextStyle? headline1,
    TextStyle? headline2,
    TextStyle? headline3,
    TextStyle? headline4,
    TextStyle? headline5,
    TextStyle? bodyText1,
    TextStyle? bodyText2,
    TextStyle? caption,
  }) {
    return AwesomeUiKitTextTheme(
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline4: headline4 ?? this.headline4,
      headline5: headline5 ?? this.headline5,
      bodyText1: bodyText1 ?? this.bodyText1,
      bodyText2: bodyText2 ?? this.bodyText2,
      caption: caption ?? this.caption,
    );
  }
}

class AwesomeUiKit {
  /// default padding of widgets
  late double padding;

  /// default font size of widgets
  late double fontSize;

  /// default radius of widgets
  late double borderRadius;

  /// duration of animations
  late Duration duration;

  /// animation duration of widgets
  late Duration animationDuration;

  /// snakcbar animation duration
  late Duration snackbarDuration;

  /// status colors of widgets
  late AwesomeUiKitStatusColors statusColors;

  /// social colors
  late AwesomeUiKitSocialColors socialColors;

  /// button sizes
  late AwesomeUiKitButtonSizes buttonSizes;

  /// font sizes
  late AwesomeUiKitTextTheme textTheme;

  factory AwesomeUiKit() => _instance;
  static final AwesomeUiKit _instance = AwesomeUiKit._internal();

  AwesomeUiKit._internal() {
    /// set deafult value
    padding = 20.0;
    fontSize = 17.0;
    borderRadius = 16.0;

    duration = const Duration(milliseconds: 250);
    animationDuration = const Duration(milliseconds: 350);
    snackbarDuration = const Duration(milliseconds: 2000);

    textTheme = AwesomeUiKitTextTheme(
      headline1: TextStyle(
        fontSize: 28.0,
        letterSpacing: 0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        fontSize: 22.0,
        letterSpacing: 0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        fontSize: 20.0,
        letterSpacing: 0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        fontSize: 18.0,
        letterSpacing: 0,
        fontWeight: FontWeight.w500,
      ),
      headline5: TextStyle(
        fontSize: 17.0,
        letterSpacing: 0,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        fontSize: 17.0,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        fontSize: 16.0,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
      ),
      caption: TextStyle(
        fontSize: 14.0,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
      ),
    );
    buttonSizes = AwesomeUiKitButtonSizes(
      extraSmall: 28.0,
      small: 35.0,
      medium: 48.0,
      large: 56.0,
    );
    statusColors = AwesomeUiKitStatusColors(
      success: Color(0xFF34C759),
      error: Color(0xFFFF2D55),
      warn: Color(0xFFFFC107),
      info: Color(0xFF5165E2),
    );
    socialColors = AwesomeUiKitSocialColors(
      whatsapp: Color(0xFF43D854),
      viber: Color(0xFF8875F0),
      vk: Color(0xFF2787F5),
    );
  }

  static AwesomeUiKit get instance => _instance;

  static Future<T?> showCupertinoModal<T>({
    required BuildContext context,
    required List<Widget> actions,
    String cancelButtonText = 'Закрыть',
    Color? cancelButtonColor,
  }) async {
    await showCupertinoModalPopup<T>(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => CupertinoActionSheet(
        actions: actions,
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancelButtonText,
            style: TextStyle(
              color: cancelButtonColor ?? Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }

  static Future<T?> showCupertinoDialog<T>({
    required BuildContext context,
    required List<Widget> actions,
    required String title,
    String? description,
    Widget? content,
  }) async {
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        actions: actions,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(letterSpacing: 0, fontWeight: FontWeight.w600),
        ),
        content: content != null
            ? content
            : description != null
                ? Container(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      description,
                      style: TextStyle(
                        height: 1.15,
                        fontSize: 13,
                        letterSpacing: 0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : null,
      ),
    );
  }
}
