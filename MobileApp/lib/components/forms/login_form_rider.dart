import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login/components/card/notification/notification.dart';
import 'package:login/components/fields/input_field.dart';
import 'package:login/components/fields/password_field.dart';
import 'package:login/components/submit_button.dart';
import 'package:login/pages/list/order_list.dart';
import 'package:login/pages/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormRider extends StatefulWidget {
  const LoginFormRider({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
    required this.callback1,
    required this.callback2,
  }) : super(key: key);

  final bool isLogin;
  final Function callback1;
  final Function callback2;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<LoginFormRider> createState() => _LoginFormRiderState();
}

class _LoginFormRiderState extends State<LoginFormRider> {
  final GlobalKey<FormState> formKeyLoginRider = GlobalKey<FormState>();

  static TextEditingController contact = TextEditingController();
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
    String token;
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.setString("mobnoRider", contact.text);
    Map<String, String> data = {"mobno": mobno, "password": password};
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://20.235.78.254/api/auth/rider"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      token = response.body;
      setState(() {
        riderToken.setString("riderToken", token);
      });
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration,
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: SizedBox(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: Form(
              key: formKeyLoginRider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  // SvgPicture.asset('assets/images/register.svg'),
                  Image.asset(
                    'assets/images/rider_login.png',
                    width: 200,
                  ),
                  const SizedBox(height: 30),
                  InputField(
                    maxlen: 10,
                    icon: Icons.phone,
                    hint: "Contact Number",
                    namecontroller: contact,
                    keyboardtype: TextInputType.number,
                    filter: FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  ),
                  PasswordField(
                    hint: "Password",
                    filter: FilteringTextInputFormatter.allow(
                        RegExp(r"[A-Za-z0-9]")),
                    keyboardtype: TextInputType.name,
                    maxlen: 10,
                    namecontroller: password,
                  ),
                  const SizedBox(height: 10),
                  SubmitButton(
                    width: widget.size.width * 0.8,
                    title: "RIDER LOGIN",
                    tap: () async {
                      if (formKeyLoginRider.currentState!.validate()) {
                        formKeyLoginRider.currentState!.save();
                        widget.callback1(true);
                        try {
                          final http.Response response =
                              await postData(contact.text, password.text);
                          if (response.statusCode == 200) {
                            widget.callback2(
                              NotificationCard(
                                body: 'You Have Successfully Logged In...',
                                onError: "",
                                onSuccess: 'OK',
                                title: 'Success',
                                typeIsSingle: true,
                                tapBack: () {},
                                tapNext: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OrderList(),
                                    ),
                                  );
                                  widget.callback1(false);
                                },
                              ),
                            );
                          } else if (response.statusCode == 400) {
                            widget.callback2(
                              NotificationCard(
                                body: 'Incorrect Credentials',
                                onError: 'Back',
                                onSuccess: 'Home',
                                title: 'Login Error',
                                typeIsSingle: false,
                                tapBack: () {
                                  widget.callback1(false);
                                },
                                tapNext: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WelcomePage(),
                                    ),
                                  );
                                  widget.callback1(false);
                                },
                              ),
                            );
                          } else {
                            widget.callback2(
                              NotificationCard(
                                body: '',
                                onError: 'Back',
                                onSuccess: 'Home',
                                title: 'Something Went Wrong',
                                typeIsSingle: false,
                                tapBack: () {
                                  widget.callback1(false);
                                },
                                tapNext: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WelcomePage(),
                                    ),
                                  );
                                  widget.callback1(false);
                                },
                              ),
                            );
                          }
                        } on TimeoutException catch (e) {
                          widget.callback2(
                            NotificationCard(
                              body: 'Check Your Connection \n and\n try again',
                              onError: '',
                              onSuccess: 'OK',
                              title: 'Connection Error!',
                              typeIsSingle: true,
                              tapBack: () {
                                widget.callback1(false);
                              },
                              tapNext: () {
                                widget.callback1(false);
                              },
                            ),
                          );
                        } catch (e) {
                          widget.callback2(NotificationCard(
                            body: e.toString(),
                            onError: '',
                            onSuccess: 'OK',
                            title: 'Connection Error!',
                            typeIsSingle: true,
                            tapBack: () {
                              widget.callback1(false);
                            },
                            tapNext: () {
                              widget.callback1(false);
                            },
                          ));
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
