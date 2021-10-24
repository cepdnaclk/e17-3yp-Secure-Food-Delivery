import 'package:example_flutter_project/src/loginPageRider.dart';
import 'package:example_flutter_project/src/loginPageUser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../WelcomePage.dart';
import 'subtitle.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  const Appbar({Key? key, required this.subtitle, required this.previous})
      : super(key: key);

  final String subtitle;
  final String previous;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Secure Food Delivery',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.yellow.shade400,
            Colors.yellowAccent.shade400,
            Colors.amber.shade900
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        ),
      ),
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: () {
          if (previous == "welcome") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WelcomePage(title: '')));
          }
          if (previous == "regcustomer") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPageUser(title: '')));
          }
          if (previous == "regrider") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPageRider(title: '')));
          }
        },
      ),
      bottom: TabBar(
        indicatorColor: Colors.white54,
        indicatorWeight: 1,
        tabs: [
          Tab(
            child: Subtitle(title: subtitle),
          ),
        ],
      ),
      elevation: 20,
      titleSpacing: 20,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}
