import 'package:flutter/material.dart';
import 'package:login/components/constants.dart';
import 'package:login/pages/list/order_list.dart';
import 'package:login/pages/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

Positioned whiteBackground(Size size) {
  return Positioned(
    child: Container(
      width: size.width,
      height: 190,
      color: kBackgroundColor,
    ),
  );
}

Widget options(BuildContext context, String title) {
  return title == "ORDERS"
      ? Positioned(
          top: 10,
          right: 12,
          child: PopupMenuButton<int>(
              onSelected: (item) => select(context, item),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Row(children: const [
                          Icon(Icons.refresh, color: Colors.black),
                          Text(" Refresh")
                        ])),
                    PopupMenuItem<int>(
                        value: 1,
                        child: Row(children: const [
                          Icon(Icons.logout, color: Colors.black),
                          Text(" Log Out")
                        ]))
                  ],
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 23, 123, 231),
                size: 35,
              )),
        )
      : const SizedBox();
}

void select(BuildContext context, int item) {
  if (item == 0) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OrderList()));
  }
  if (item == 1) {
    clearToken();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WelcomePage()));
  }
}

clearToken() async {
  SharedPreferences riderToken = await SharedPreferences.getInstance();
  riderToken.remove('riderToken');
  riderToken.setBool('login', false);
}

Positioned homeButton(BuildContext context) {
  return Positioned(
    top: 12,
    left: 12,
    child: IconButton(
      icon: const Icon(
        Icons.home,
        size: 35,
        color: Color.fromARGB(255, 157, 198, 241),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
        );
      },
    ),
  );
}

Positioned circle1() {
  return Positioned(
    top: -50,
    left: -50,
    child: Container(
      width: 190,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: kPrimaryColor,
      ),
    ),
  );
}

Positioned circle2() {
  return Positioned(
    top: 50,
    right: -50,
    child: Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: kPrimaryColor,
      ),
    ),
  );
}

Positioned mainTitle(Size size, String title) {
  return Positioned.fill(
    top: 130,
    child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: kPrimaryColor,
        ),
      ),
    ),
  );
}

Stack topBar(Size size, String title, BuildContext context) {
  return Stack(
    children: [
      whiteBackground(size),
      circle2(),
      circle1(),
      mainTitle(size, title),
      homeButton(context),
      options(context, title)
    ],
  );
}
