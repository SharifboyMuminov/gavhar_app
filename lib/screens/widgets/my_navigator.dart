import 'package:flutter/material.dart';

myNavigator(BuildContext context, {required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ),
  );
}
