import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'WelcomePage.dart';
import 'Widget/body.dart';
import 'Widget/appbar.dart';
import 'Widget/textForm.dart';
import 'Widget/bottomlink.dart';
import 'Widget/submitbutton.dart';

class SignUpPageRider extends StatefulWidget {
  SignUpPageRider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageRiderState createState() => _SignUpPageRiderState();
}

class _SignUpPageRiderState extends State<SignUpPageRider> {
  final GlobalKey<FormState> _formKeySignupRider = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController deviceid = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<http.Response> postData(
      String rname, String mobno, String deviceid, String password) async {
    Map<String, String> data = {
      "rname": rname,
      "mobno": mobno,
      "deviceid": deviceid,
      "password": password
    };
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://35.171.26.170/api/users/rider"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print(response.body);
    print(response.statusCode);
    return response;
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeySignupRider.currentState!.validate()) {
            _formKeySignupRider.currentState!.save();
            print(name.text);
            print(contact.text);
            print(deviceid.text);
            print(password.text);
            final http.Response response = await postData(
                name.text, contact.text, deviceid.text, password.text);
            if (response.statusCode == 200) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Registered Successfully!!!'),
                  content: Text(response.body),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(
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
                  title: const Text('Register Error'),
                  content: Text(response.body),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Go to Main Page'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage(
                                    title: '',
                                  ))),
                    ),
                  ],
                ),
              );
            } else if (response.statusCode == 406) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Register Error'),
                  content: Text(response.body),
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
        child: SubmitButton(buttontext: "Register Now"));
  }

  Widget _widget() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        TextForm(
            namecontroller: name,
            name: "Name",
            keyboardtype: TextInputType.name,
            maxlen: 20,
            hint: "Enter First Name & Last Name Here",
            icon: Icon(Icons.person),
            filter: FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z]| |")),
            passwordtrue: false),
        TextForm(
            namecontroller: contact,
            name: "Contact Number",
            keyboardtype: TextInputType.number,
            maxlen: 10,
            hint: "Enter Contact Number Here",
            icon: Icon(Icons.phone_android),
            filter: FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
            passwordtrue: false),
        TextForm(
            namecontroller: deviceid,
            name: "Device ID",
            keyboardtype: TextInputType.name,
            maxlen: 10,
            hint: "Enter Device ID Here",
            icon: Icon(Icons.delivery_dining_rounded),
            filter: FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9]")),
            passwordtrue: false),
        TextForm(
            namecontroller: password,
            name: "Password",
            keyboardtype: TextInputType.visiblePassword,
            maxlen: 10,
            hint: "Enter Password Here",
            icon: Icon(Icons.security_sharp),
            filter: FilteringTextInputFormatter.allow(
                RegExp(r"[A-Za-z0-9,.:;!<>?=@#$%&*()_+/-[]")),
            passwordtrue: true),
        SizedBox(height: 20),
        _submitButton(),
        BottomLink(
            navigate: "LoginPageRider",
            description: "Already have an account ?",
            link: "Login")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: Appbar(
            subtitle: "Rider register",
            previous: "regrider",
          ),
          body: Safearea(formkey: _formKeySignupRider, body: _widget())),
    );
  }
}
