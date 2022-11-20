import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:login/components/card/notification/notification.dart';
import 'package:login/components/constants.dart';
import 'package:login/components/fields/input_field.dart';
import 'package:login/components/submit_button.dart';
import 'package:login/pages/login/login_customer.dart';
import 'package:login/pages/welcome/welcome.dart';

class RegisterFormCustomer extends StatefulWidget {
  const RegisterFormCustomer({
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
  State<RegisterFormCustomer> createState() => _RegisterFormCustomerState();
}

class _RegisterFormCustomerState extends State<RegisterFormCustomer> {
  final GlobalKey<FormState> formKeySignupCustomer = GlobalKey<FormState>();

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
      Uri.parse("https://20.235.78.254/api/users/customer"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: SizedBox(
              width: widget.size.width,
              height: widget.defaultLoginSize,
              child: Form(
                key: formKeySignupCustomer,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // SvgPicture.asset('assets/images/login.svg'),
                    const SizedBox(height: 10),
                    InputField(
                      hint: "Name",
                      namecontroller: name,
                      icon: Icons.person,
                      filter: FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z ]")),
                      keyboardtype: TextInputType.text,
                      maxlen: 20,
                    ),
                    InputField(
                      hint: "Contact Number",
                      icon: Icons.phone,
                      namecontroller: contact,
                      filter:
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                      keyboardtype: TextInputType.number,
                      maxlen: 10,
                    ),
                    InputField(
                      hint: "Email",
                      icon: Icons.email,
                      namecontroller: email,
                      filter: FilteringTextInputFormatter.allow(
                          RegExp(r"[A-Za-z0-9]|@|\.")),
                      keyboardtype: TextInputType.emailAddress,
                      maxlen: 50,
                    ),
                    InputField(
                      hint: "Address",
                      maxlen: 50,
                      namecontroller: address,
                      filter: FilteringTextInputFormatter.allow(
                          RegExp(r"[A-Za-z0-9]|/|,| |\.")),
                      keyboardtype: TextInputType.streetAddress,
                      icon: Icons.location_on,
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      width: widget.size.width * 0.8,
                      title: "SIGN UP",
                      tap: () async {
                        if (formKeySignupCustomer.currentState!.validate()) {
                          formKeySignupCustomer.currentState!.save();
                          widget.callback1(true);
                          try {
                            final http.Response response = await postData(
                                name.text,
                                contact.text,
                                address.text,
                                email.text);
                            if (response.statusCode == 200) {
                              widget.callback2(NotificationCard(
                                body:
                                    "You have Successfully Registered\n\nLet's Login",
                                onError: '',
                                onSuccess: 'OK',
                                title: 'Success',
                                typeIsSingle: true,
                                tapBack: () {},
                                tapNext: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginCustomer(),
                                    ),
                                  );
                                  widget.callback1(false);
                                },
                              ));
                            } else if (response.statusCode == 400 ||
                                response.statusCode == 406) {
                              widget.callback2(NotificationCard(
                                body: response.body,
                                onError: 'Back',
                                onSuccess: 'Home',
                                title: 'Register Error',
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
                              ));
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
                                        builder: (context) =>
                                            const WelcomePage(),
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
                                body:
                                    'Check Your Connection \n and\n try again',
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
        ),
      ),
    );
  }
}
