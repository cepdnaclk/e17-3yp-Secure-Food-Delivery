import 'package:flutter/material.dart';
import 'dart:math';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: pi * 2,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width * 2,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.yellow.shade100,
            Colors.yellow.shade400,
            Colors.yellowAccent.shade400,
            Colors.amber.shade900,
          ], begin: Alignment.centerRight, end: Alignment.topCenter)),
        ),
      ),
    ));
  }
}
