import 'package:flutter/material.dart';
import 'package:login/components/constants.dart';

class WelcomePageBackground extends StatelessWidget {
  final Widget child;
  const WelcomePageBackground({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/top1.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
                width: size.width,
                color: kPrimaryColor,
              )),
          Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/top2.png",
                width: size.width,
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
                color: kPrimaryColor,
              )),
          Positioned.fill(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/bottom1.png",
                width: size.width,
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
                color: kPrimaryColor,
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bottom2.png",
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
              color: kPrimaryColor,
            ),
          ),
          child
        ],
      ),
    );
  }
}
