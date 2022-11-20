import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login/components/card/notification/notification.dart';
import 'package:login/components/fields/password_field.dart';
import 'package:login/components/submit_button.dart';
import 'package:login/pages/login/login_customer.dart';
import 'package:login/pages/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnlockForm extends StatefulWidget {
  const UnlockForm({
    Key? key,
    required this.size,
    required this.defaultLoginSize,
    required this.callback1,
    required this.callback2,
  }) : super(key: key);

  final Function callback1;
  final Function callback2;
  final Size size;
  final double defaultLoginSize;

  @override
  State<UnlockForm> createState() => _UnlockFormState();
}

class _UnlockFormState extends State<UnlockForm> {
  final GlobalKey<FormState> formKeyUnlock = GlobalKey<FormState>();

  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginUser();
  }

  checkLoginUser() async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    if (userToken.getString("userToken") == null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginCustomer()));
    }
  }

  Future<http.Response> postData(String otp) async {
    SharedPreferences userToken = await SharedPreferences.getInstance();
    String? token = userToken.getString('userToken');

    Map<String, String> data = {"otp": otp};
    final body = jsonEncode(data);

    final response = await http.post(
      Uri.parse("https://20.235.78.254/api/order_access/unlock"),
      headers: {
        "Content-Type": "application/json",
        "x-authtoken": token.toString(),
        "Connection": "keep-alive"
      },
      body: body,
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: Form(
            key: formKeyUnlock,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/unlock.png',
                  width: 300,
                ),
                const SizedBox(height: 30),
                PasswordField(
                  hint: "OTP",
                  filter: FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  keyboardtype: TextInputType.number,
                  maxlen: 6,
                  namecontroller: otp,
                ),
                const SizedBox(height: 10),
                SubmitButton(
                  width: widget.size.width * 0.8,
                  title: "UNLOCK NOW",
                  tap: () async {
                    if (formKeyUnlock.currentState!.validate()) {
                      formKeyUnlock.currentState!.save();
                      widget.callback1(true);
                      try {
                        final response = await postData(otp.text);
                        if (response.statusCode == 200) {
                          SharedPreferences userToken =
                              await SharedPreferences.getInstance();
                          userToken.remove("userToken");
                          widget.callback2(
                            NotificationCard(
                              body: response.body,
                              onError: '',
                              onSuccess: 'OK',
                              title: 'Done',
                              typeIsSingle: true,
                              tapBack: () {},
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
                        } else if (response.statusCode == 400 ||
                            response.statusCode == 401) {
                          widget.callback2(
                            NotificationCard(
                              body: response.body,
                              onError: 'Back',
                              onSuccess: 'Home',
                              title: 'Error',
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
                            tapBack: () {},
                            tapNext: () {
                              widget.callback1(false);
                            },
                          ),
                        );
                      } catch (e) {
                        widget.callback2(
                          NotificationCard(
                            body: e.toString(),
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
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
