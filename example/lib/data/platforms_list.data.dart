import 'package:flutter/material.dart';
import 'package:example/models/models.dart';

final List<PlatformItem> platforms = [
  PlatformItem(
    'Android',
    Image.asset(
      'assets/platforms/android.gif',
      width: 32.0,
      height: 32.0,
    ),
  ),
  PlatformItem(
    'iOS',
    Image.asset(
      'assets/platforms/iOS.png',
      width: 32.0,
      height: 32.0,
    ),
  ),
  PlatformItem(
    'Windows',
    Image.asset(
      'assets/platforms/windows.png',
      width: 32.0,
      height: 32.0,
    ),
  ),
  PlatformItem(
    'Linux',
    Image.asset(
      'assets/platforms/linux.png',
      width: 32.0,
      height: 32.0,
    ),
  ),
  PlatformItem(
    'MacOS',
    Image.asset(
      'assets/platforms/macOS.png',
      width: 32.0,
      height: 32.0,
    ),
  ),
  PlatformItem(
    'Web',
    Container(
      width: 32.0,
      height: 32.0,
    ),
  ),
];
