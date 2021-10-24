import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'unlockPage.dart';
import 'Widget/body.dart';
import 'WelcomePage.dart';
import 'Widget/appbar.dart';
import 'Widget/textForm.dart';
import 'Widget/bottomlink.dart';
import 'Widget/submitbutton.dart';

class LoginPageUser extends StatefulWidget {
  LoginPageUser({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageUser> {
  final GlobalKey<FormState> _formKeyLoginUser = GlobalKey<FormState>();

  TextEditingController contact = TextEditingController();
  TextEditingController orderid = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initNumber();
  }

  _initNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("mobno") != null) {
      contact.text = pref.getString("mobno")!;
    }
  }

  Future<http.Response> postData(String mobno, String orderid) async {
    var token;
    SharedPreferences userToken = await SharedPreferences.getInstance();
    userToken.setString("mobno", contact.text);

    Map<String, String> data = {"mobno": mobno, "orderid": orderid};
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://35.171.26.170/api/auth/customer"),
      headers: {"Content-Type": "application/json", "connection": "keep-alive"},
      body: body,
    );
    if (response.statusCode == 200) {
      token = response.body;
      setState(() {
        userToken.setString("userToken", token);
      });
    }
    return response;
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeyLoginUser.currentState!.validate()) {
            _formKeyLoginUser.currentState!.save();

            final response = await postData(contact.text, orderid.text);
            if (response.statusCode == 200) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Successfully'),
                  content: const Text(''),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnlockPage(
                            title: '',
                          ),
                        ),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (response.statusCode == 400 ||
                response.statusCode == 401) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Error'),
                  content: Text(response.body),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (response.statusCode == 404) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Error'),
                  content: const Text('Order Processed Already'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Something Went Wrong'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Colors.red,
                        ),
                      ),
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
          namecontroller: orderid,
          name: "Order ID",
          keyboardtype: TextInputType.name,
          maxlen: 10,
          hint: "Enter Order ID Here",
          icon: Icon(Icons.delivery_dining_rounded),
          filter: FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9]")),
          passwordtrue: false,
        ),
        SizedBox(height: height * 0.31),
        _submitButton(),
        BottomLink(
            navigate: "SignUpPageUser",
            description: "Want to become Pro User? ",
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
              subtitle: "Customer Login",
              previous: "welcome",
            ),
            body: Safearea(formkey: _formKeyLoginUser, body: _widget())));
  }
}
