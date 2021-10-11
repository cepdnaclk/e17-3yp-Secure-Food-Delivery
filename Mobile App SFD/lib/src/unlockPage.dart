import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      // userToken.setString("errUser", "err");

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPageUser(title: '')));
    }
  }

  getToken() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    String? token = userToken.getString('userToken');
    return token;
  }

  Future postData(String otp) async {
    try {
      final response = await post(
        // Uri.parse('https://192.168.1.10/api/order_access/unlock'),
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {
          'otp': otp,
        },
      );
      print(response.statusCode);
      print(response.body);
      // return response.statusCode;
      return 200;
    } catch (err) {}
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeyUnlock.currentState!.validate()) {
            _formKeyUnlock.currentState!.save();
            print(otp.text);
            var statusCode = await postData(otp.text);
            if (statusCode == 200) {
              SharedPreferences userToken =
                  await SharedPreferences.getInstance();
              userToken.remove("userToken");
              // userToken.remove("errUser");
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Successfully Unlocked!!!'),
                  content: const Text(''),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomePage(title: ''),
                        ),
                      ),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
              // } else if (statusCode == 400 || statusCode == 401) {
              //   showDialog<String>(
              //     context: context,
              //     builder: (BuildContext context) => AlertDialog(
              //       title: const Text('Error!!!'),
              //       content: const Text('Incorrect Credentials'),
              //       actions: <Widget>[
              //         TextButton(
              //           onPressed: () => Navigator.pop(context),
              //           child: const Text('Cancel'),
              //         ),
              //         TextButton(
              //           onPressed: () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => WelcomePage(
              //                         title: '',
              //                       ))),
              //           child: const Text('Go to Main Page'),
              //         ),
              //       ],
              //     ),
              //   );
              // } else if (statusCode == 404) {
              //   showDialog<String>(
              //     context: context,
              //     builder: (BuildContext context) => AlertDialog(
              //       title: const Text('Login Error!!!'),
              //       content: const Text('Order Processed Already'),
              //       actions: <Widget>[
              //         TextButton(
              //           onPressed: () => Navigator.pop(context),
              //           child: const Text('Cancel'),
              //         ),
              //         TextButton(
              //           onPressed: () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => WelcomePage(
              //                         title: '',
              //                       ))),
              //           child: const Text('Go to Main Page'),
              //         ),
              //       ],
              //     ),
              //   );
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
          appBar: Appbar(subtitle: "Unlock Your Order"),
          body: Safearea(formkey: _formKeyUnlock, body: _widget())),
    );
  }
}
