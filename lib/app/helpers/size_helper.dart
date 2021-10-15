import 'package:flutter/cupertino.dart';

class SizeHelper {
  static double getWidth(BuildContext context, value) {
    return (MediaQuery.of(context).size.width * value) / 100;
  }

  static double getHeight(BuildContext context, value) {
    return (MediaQuery.of(context).size.height * value) / 100;
  }

  static bool isPortrait(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return true;
    } else {
      return false;
    }
  }
}
