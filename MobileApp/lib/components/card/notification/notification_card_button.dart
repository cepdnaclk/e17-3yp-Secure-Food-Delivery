import 'package:flutter/material.dart';
import 'package:login/components/constants.dart';

class NotificationCardButton extends StatelessWidget {
  const NotificationCardButton({
    Key? key,
    required this.onSubmit,
    required this.tap,
  }) : super(key: key);

  final String onSubmit;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      onPressed: tap,
      child: Text(
        onSubmit,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 20),
      ),
    );
  }
}
