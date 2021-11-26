import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:example/ui/animated_view.dart';
import 'package:example/ui/home/home_view.dart';
import 'package:example/ui/platforms/platforms_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Input',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white,
          disabledColor: Color(0xFFEEF0F2),
          primaryColor: Colors.deepPurple,
          dividerColor: Color(0xFFC6C6C8),
          backgroundColor: Color(0xFFEFEFF4),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          colorScheme: ColorScheme(
            primary: Color(0xFF3C3C43).withOpacity(0.6),
            primaryVariant: Color(0xFF000000),
            onPrimary: Colors.white,
            secondary: Colors.deepPurple,
            secondaryVariant: darken(Colors.deepPurple, 0.15),
            onSecondary: Colors.white,
            error: Color(0xFFF74969),
            onError: Colors.white,
            brightness: Brightness.light,
            background: Color(0xFFD1D1D6),
            onBackground: Color(0xFF000000),
            surface: Colors.white,
            onSurface: Color(0xFF000000),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              height: 1.45,
              fontSize: 17,
              letterSpacing: -0.14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
            bodyText2: TextStyle(
              fontSize: 16,
              letterSpacing: -0.14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          )),
      home: AwesomeUiView(),
    );
  }
}

class AwesomeUiView extends StatefulWidget {
  @override
  _AwesomeUiViewState createState() => _AwesomeUiViewState();
}

class _AwesomeUiViewState extends State<AwesomeUiView> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    PlatformsView(),
    AnimatedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        activeColor: Theme.of(context).colorScheme.primaryVariant,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(CupertinoIcons.person_crop_circle_fill),
            activeIcon: Icon(
              CupertinoIcons.person_crop_circle_fill,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(CupertinoIcons.search),
            activeIcon: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            activeIcon: Icon(
              CupertinoIcons.chat_bubble_2_fill,
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return _widgetOptions.elementAt(_selectedIndex);
      },
    );
  }
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
