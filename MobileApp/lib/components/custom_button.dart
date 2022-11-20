import 'package:flutter/material.dart';
import 'package:login/components/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.tap,
    required this.text,
    required this.width,
  }) : super(key: key);

  final GestureTapCallback tap;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: tap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
          ),
          shadowColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 0, 0, 63),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0), color: kPrimaryColor),
          padding: const EdgeInsets.all(0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
