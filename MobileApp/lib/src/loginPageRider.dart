import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderList.dart';
import 'WelcomePage.dart';
import 'Widget/body.dart';
import 'Widget/appbar.dart';
import 'Widget/textForm.dart';
import 'Widget/bottomlink.dart';
import 'Widget/submitbutton.dart';

class LoginPageRider extends StatefulWidget {
  LoginPageRider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageRider> {
  final GlobalKey<FormState> _formKeyLoginRider = GlobalKey<FormState>();

  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginRider();
  }

  _checkLoginRider() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    if (riderToken.getString("mobnoRider") != null) {
      contact.text = riderToken.getString("mobnoRider")!;
    }
  }

  Future<http.Response> postData(String mobno, String password) async {
    var token;
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.setString("mobnoRider", contact.text);
    Map<String, String> data = {"mobno": mobno, "password": password};
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://35.171.26.170/api/auth/rider"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      token = response.body;
      print(token);
      setState(() {
        riderToken.setString("riderToken", token);
      });
    }
    print(response.statusCode);
    return response;
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeyLoginRider.currentState!.validate()) {
            _formKeyLoginRider.currentState!.save();
            print(contact.text);
            print(password.text);
            // setState(() {
            //   _isLoading = true;
            // });
            final http.Response response =
                await postData(contact.text, password.text);
            if (response.statusCode == 200) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Successfully!!!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderList(
                            title: '',
                          ),
                        ),
                      ),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            } else if (response.statusCode == 400) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Error!!!'),
                  content: const Text('Incorrect Credentials'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage(
                                    title: '',
                                  ))),
                      child: const Text('Go to Main Page'),
                    ),
                  ],
                ),
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Something Went Wrong!!!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          }
        },
        child: SubmitButton(buttontext: "Login"));
  }

  Widget _widget() {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        TextForm(
          namecontroller: contact,
          name: "Contact Number",
          keyboardtype: TextInputType.number,
          maxlen: 10,
          hint: "Enter Contact Number Here",
          icon: Icon(Icons.phone_android),
          filter: FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
          passwordtrue: false,
        ),
        TextForm(
          namecontroller: password,
          name: "Password",
          keyboardtype: TextInputType.visiblePassword,
          maxlen: 10,
          hint: "Enter Password Here",
          icon: Icon(Icons.security_sharp),
          filter: FilteringTextInputFormatter.allow(
              RegExp(r"[A-Za-z0-9,.:;!<>?=@#$%&*()_+/-[]")),
          passwordtrue: true,
        ),
        SizedBox(height: height * 0.31),
        _submitButton(),
        BottomLink(
            navigate: "SignUpPageRider",
            description: "Don\'t have an account ?",
            link: "Register")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: Appbar(
              subtitle: "Rider Login",
              previous: "welcome",
            ),
            body: Safearea(formkey: _formKeyLoginRider, body: _widget())));
  }
}
