import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'WelcomePage.dart';
import 'loginPageUser.dart';
import 'Widget/body.dart';
import 'Widget/appbar.dart';
import 'Widget/textForm.dart';
import 'Widget/submitbutton.dart';

class UnlockPage extends StatefulWidget {
  UnlockPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _UnlockPageState createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  final GlobalKey<FormState> _formKeyUnlock = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginUser();
  }

  checkLoginUser() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    if (userToken.getString("userToken") == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPageUser(title: '')));
    }
  }

  Future<http.Response> postData(String otp) async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    String? token = userToken.getString('userToken');

    Map<String, String> data = {"otp": otp};
    final body = jsonEncode(data);

    final response = await http.post(
      Uri.parse("https://35.171.26.170/api/order_access/unlock"),
      headers: {
        "Content-Type": "application/json",
        "x-authtoken": token.toString(),
        "Connection": "keep-alive"
      },
      body: body,
    );
    return response;
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeyUnlock.currentState!.validate()) {
            _formKeyUnlock.currentState!.save();
            print(otp.text);
            final http.Response response = await postData(otp.text);
            if (response.statusCode == 200) {
              SharedPreferences userToken =
                  await SharedPreferences.getInstance();
              userToken.remove("userToken");
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(response.body),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(title: ''),
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
                  title: const Text('Error'),
                  content: const Text('Access Denied'),
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
            } else if (response.statusCode == 401) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Login Error'),
                  content: const Text('Rider on the way.\nNeeds to confirm.'),
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
        child: SubmitButton(buttontext: "Unlock Now"));
  }

  Widget _widget() {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        TextForm(
            namecontroller: otp,
            name: "OTP",
            keyboardtype: TextInputType.number,
            maxlen: 6,
            hint: "Enter OTP Here",
            icon: Icon(Icons.security_sharp),
            filter: FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
            passwordtrue: true),
        SizedBox(height: height * 0.55),
        _submitButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: Appbar(
            subtitle: "Unlock Your Order",
            previous: "regcustomer",
          ),
          body: Safearea(formkey: _formKeyUnlock, body: _widget())),
    );
  }
}
