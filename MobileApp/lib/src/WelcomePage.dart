import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderList.dart';
import 'loginPageUser.dart';
import 'loginPageRider.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    _checkLoginRider();
  }

  _checkLoginRider() async {
    SharedPreferences Token = await SharedPreferences.getInstance();
    Token.remove('userToken');
    if (Token.getString("riderToken") != null) {
      if (Token.getBool('login') == true) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderList(title: '')));
      }
    }
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Secure ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Food ',
              style: TextStyle(color: Colors.black, fontSize: 35),
            ),
            TextSpan(
              text: 'Delivery',
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
          ]),
    );
  }

  Widget _submitButton(String S) {
    return InkWell(
      onTap: () {
        if (S == 'Customer') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPageUser(
                        title: '',
                      )));
        } else if (S == 'Rider') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPageRider(
                        title: '',
                      )));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          S,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.yellow.shade400,
        Colors.yellowAccent.shade400,
        Colors.amber.shade900
      ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.15),
          _title(),
          Image.asset('assets/welcome_img.png',
              width: width * 0.6, height: height * 0.5),
          _submitButton('Customer'),
          SizedBox(height: 20),
          _submitButton('Rider'),
        ],
      ),
    ));
  }
}
