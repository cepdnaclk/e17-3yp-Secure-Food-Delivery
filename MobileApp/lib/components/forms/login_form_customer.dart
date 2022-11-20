import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login/components/card/notification/notification.dart';
import 'package:login/components/fields/input_field.dart';
import 'package:login/components/fields/password_field.dart';
import 'package:login/components/submit_button.dart';
import 'package:login/pages/unlock/unlockPage.dart';
import 'package:login/pages/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormCustomer extends StatefulWidget {
  const LoginFormCustomer({
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
  State<LoginFormCustomer> createState() => _LoginFormCustomerState();
}

class _LoginFormCustomerState extends State<LoginFormCustomer> {
  final GlobalKey<FormState> formKeyLoginCustomer = GlobalKey<FormState>();

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
    String token;
    SharedPreferences userToken = await SharedPreferences.getInstance();
    userToken.setString("mobno", contact.text);

    Map<String, String> data = {"mobno": mobno, "orderid": orderid};
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("https://20.235.78.254/api/auth/customer"),
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
              key: formKeyLoginCustomer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  // SvgPicture.asset('assets/images/register.svg'),
                  Image.asset(
                    'assets/images/login_customer.jpg',
                    width: 150,
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
                    hint: "Order ID",
                    filter: FilteringTextInputFormatter.allow(
                        RegExp(r"[A-Za-z0-9]")),
                    keyboardtype: TextInputType.name,
                    maxlen: 10,
                    namecontroller: orderid,
                  ),
                  const SizedBox(height: 10),
                  SubmitButton(
                    width: widget.size.width * 0.8,
                    title: "CUSTOMER LOGIN",
                    tap: () async {
                      if (formKeyLoginCustomer.currentState!.validate()) {
                        formKeyLoginCustomer.currentState!.save();
                        widget.callback1(true);
                        try {
                          final response =
                              await postData(contact.text, orderid.text);
                          if (response.statusCode == 200) {
                            widget.callback2(NotificationCard(
                              body: 'You have Successfully Logged In...',
                              onError: '',
                              onSuccess: 'OK',
                              title: 'Success',
                              typeIsSingle: true,
                              tapBack: () {},
                              tapNext: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UnlockPage(),
                                  ),
                                );
                              },
                            ));
                          } else if (response.statusCode == 400 ||
                              response.statusCode == 401 ||
                              response.statusCode == 404) {
                            widget.callback2(
                              NotificationCard(
                                body: response.body,
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
                                },
                              ),
                            );
                          } else {
                            widget.callback2(
                              NotificationCard(
                                body: "",
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
                              tapBack: () {},
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
                            tapBack: () {},
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
