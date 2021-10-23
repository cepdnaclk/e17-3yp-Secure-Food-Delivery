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

class SignUpPageUser extends StatefulWidget {
  SignUpPageUser({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageUser> {
  final GlobalKey<FormState> _formKeySignupUser = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<http.Response> postData(
      String cname, String mobno, String caddress, String email) async {
    Map<String, String> data = {
      "cname": cname,
      "mobno": mobno,
      "caddress": caddress,
      "email": email
    };
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://35.171.26.170/api/users/customer"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeySignupUser.currentState!.validate()) {
            _formKeySignupUser.currentState!.save();
            final http.Response response = await postData(
                name.text, contact.text, address.text, email.text);
            if (response.statusCode == 200) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Registered Successfully'),
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
            } else if (response.statusCode == 400) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Register Error'),
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
            } else if (response.statusCode == 406) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Register Error'),
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
        child: SubmitButton(buttontext: "Register Now"));
  }

  Widget _widget() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        TextForm(
          namecontroller: name,
          name: "Name",
          keyboardtype: TextInputType.text,
          maxlen: 20,
          hint: "Enter First Name & Last Name Here",
          icon: Icon(Icons.person),
          filter: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")),
          passwordtrue: false,
        ),
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
          namecontroller: email,
          name: "Email",
          keyboardtype: TextInputType.emailAddress,
          maxlen: 50,
          hint: "Enter Email Here",
          icon: Icon(Icons.email),
          filter:
              FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9]|@|\.")),
          passwordtrue: false,
        ),
        TextForm(
          namecontroller: address,
          name: "Address",
          keyboardtype: TextInputType.streetAddress,
          maxlen: 50,
          hint: "Enter Address Here",
          icon: Icon(Icons.location_on),
          filter: FilteringTextInputFormatter.allow(
              RegExp(r"[A-Za-z0-9]|/|,| |\.")),
          passwordtrue: false,
        ),
        SizedBox(height: 20),
        _submitButton(),
        BottomLink(
            navigate: "LoginPageUser",
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
            subtitle: "Customer Register",
            previous: "regcustomer",
          ),
          body: Safearea(formkey: _formKeySignupUser, body: _widget())),
    );
  }
}
