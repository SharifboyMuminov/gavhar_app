import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gavhar_app/screens/widgets/backgeound_conteyner.dart';
import 'package:gavhar_app/utils/size_app.dart';

class BackGroundItem extends StatelessWidget {
  const BackGroundItem({
    super.key,
     this.colorOne = Colors.yellow,
     this.colorTwo = Colors.limeAccent,
     this.colorThree = Colors.orangeAccent,
  });

  final Color colorOne;
  final Color colorTwo;
  final Color colorThree;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20.he,
          left: -100.we,
          child:  BackGroundContainer(color: colorOne),
        ),
        Positioned(
          bottom: 30.he,
          right: -200.we,
          child:  BackGroundContainer(
            color: colorTwo,
          ),
        ),
        Positioned(
          bottom: -180.he,
          left: -80.we,
          child:  BackGroundContainer(
            color: colorThree,
          ),
        ),
        Container(
          width: width,
          height: height,
          color: Colors.white24,
        ),
      ],
    );
  }
}
