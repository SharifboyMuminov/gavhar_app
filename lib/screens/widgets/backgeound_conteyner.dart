import 'package:flutter/material.dart';
import 'package:gavhar_app/utils/size_app.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({super.key, this.color = Colors.yellow});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.we,
      height: 300.we,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
