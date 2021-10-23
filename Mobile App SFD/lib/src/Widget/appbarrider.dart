import 'package:example_flutter_project/src/orderList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:example_flutter_project/src/loginPageRider.dart';
import '../WelcomePage.dart';
import 'subtitle.dart';

class AppbarRider extends StatelessWidget with PreferredSizeWidget {
  const AppbarRider({Key? key, required this.subtitle, required this.previous})
      : super(key: key);

  final String subtitle;
  final String previous;

  clearToken() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.remove('riderToken');
    riderToken.setBool('login', false);
  }

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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPageRider(title: '')));
        },
      ),
      actions: <Widget>[
        PopupMenuButton<int>(
            onSelected: (item) => Select(context, item),
            itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(children: [
                        Icon(Icons.refresh, color: Colors.black),
                        Text(" Refresh")
                      ])),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(children: [
                        Icon(Icons.logout, color: Colors.black),
                        Text(" Log Out")
                      ]))
                ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            )),
      ],
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

  void Select(BuildContext context, int item) {
    if (item == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OrderList(title: '')));
    }
    if (item == 1) {
      clearToken();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePage(title: '')));
    }
  }
}
