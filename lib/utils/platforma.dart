import 'package:flutter/foundation.dart';

class Platforma {
  static bool get ios => defaultTargetPlatform == TargetPlatform.iOS;

  static bool get android => defaultTargetPlatform == TargetPlatform.android;
}
