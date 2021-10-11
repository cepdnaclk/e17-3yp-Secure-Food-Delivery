import 'package:flutter/material.dart';
// import 'package:flutter_driver/driver_extension.dart';
// import 'package:driver_extensions/driver_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/welcomePage.dart';

void main() {
  // enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Secure Food Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomePage(
          title: '',
        ));
  }
}
