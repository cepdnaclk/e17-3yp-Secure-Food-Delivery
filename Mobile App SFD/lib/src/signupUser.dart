import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

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

  Future postData(
      String cname, String mobno, String caddress, String email) async {
    try {
      final response = await post(
          Uri.parse("https://35.171.26.170/api/users/customer"),
          body: {
            "cname": cname,
            "mobno": mobno,
            "caddress": caddress,
            "email": email
          });
      print(response.body);
      print(response.statusCode);
      return response.statusCode;
    } catch (err) {}
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {
          if (_formKeySignupUser.currentState!.validate()) {
            _formKeySignupUser.currentState!.save();
            print(name.text);
            print(contact.text);
            print(email.text);
            print(address.text);
            var statusCode = await postData(
                name.text, contact.text, address.text, email.text);
            if (statusCode == 200) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Registered Successfully!!!'),
                  content:
                      const Text('Let\'s Login to the Secure Food Delivery'),
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
            } else if (statusCode == 400) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Register Error'),
                  content: const Text('Incorrect Inputs'),
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
            } else if (statusCode == 406) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Register Error'),
                  content: const Text('Failed to Register'),
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
          appBar: Appbar(subtitle: "Customer Register"),
          body: Safearea(formkey: _formKeySignupUser, body: _widget())),
    );
  }
}
