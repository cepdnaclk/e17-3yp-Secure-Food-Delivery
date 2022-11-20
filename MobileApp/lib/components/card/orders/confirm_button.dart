import 'package:flutter/material.dart';
import 'package:login/components/constants.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required this.tap,
    required this.width,
  }) : super(key: key);

  final GestureTapCallback tap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: width / 3.5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(6, 6))
          ],
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 199, 227, 241),
        ),
        padding: const EdgeInsets.symmetric(vertical: 3),
        alignment: Alignment.center,
        child: const Text(
          'Confirm',
          style: TextStyle(color: kPrimaryColor, fontSize: 18),
        ),
      ),
    );
  }
}
