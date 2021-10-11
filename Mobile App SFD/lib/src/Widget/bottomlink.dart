import 'package:flutter/material.dart';

import '../loginPageRider.dart';
import '../loginPageUser.dart';
import '../signupRider.dart';
import '../signupUser.dart';

class BottomLink extends StatelessWidget {
  BottomLink(
      {Key? key,
      required this.navigate,
      required this.description,
      required this.link})
      : super(key: key);

  final String navigate;
  final String description;
  final String link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigate == "LoginPageUser") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPageUser(
                        title: '',
                      )));
        }
        if (navigate == "SignUpPageRider") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPageRider(
                        title: '',
                      )));
        }
        if (navigate == "SignUpPageUser") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpPageUser(
                        title: '',
                      )));
        }
        if (navigate == "LoginPageRider") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPageRider(
                        title: '',
                      )));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              description,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              link,
              style: TextStyle(
                  color: Colors.orange.shade900,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
