import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Validate/validators.dart';

class TextForm extends StatelessWidget {
  TextForm({
    Key? key,
    required this.namecontroller,
    required this.name,
    required this.keyboardtype,
    required this.maxlen,
    required this.hint,
    required this.icon,
    required this.filter,
    required this.passwordtrue,
  }) : super(key: key);

  final FilteringTextInputFormatter filter;
  final TextEditingController namecontroller;
  final TextInputType keyboardtype;
  final bool passwordtrue;
  final String name;
  final String hint;
  final int maxlen;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            obscureText: passwordtrue,
            keyboardType: keyboardtype,
            inputFormatters: <TextInputFormatter>[filter],
            maxLength: maxlen,
            controller: namecontroller,
            validator: (v) {
              if (name == "Name") {
                if (v!.isValidName == "valid") {
                  return null;
                } else {
                  return v.isValidName;
                }
              }
              if (name == "Contact Number") {
                if (v!.isValidPhone == "valid") {
                  return null;
                } else {
                  return v.isValidPhone;
                }
              }
              if (name == "Email") {
                if (v!.isValidEmail == "valid") {
                  return null;
                } else {
                  return v.isValidEmail;
                }
              }
              if (name == "Address") {
                if (v!.isValidAddress == "valid") {
                  return null;
                } else {
                  return v.isValidAddress;
                }
              }
              if (name == "Order ID") {
                if (v!.isValidOrderId == "valid") {
                  return null;
                } else {
                  return v.isValidOrderId;
                }
              }
              if (name == "Password") {
                if (v!.isValidPassword == "valid") {
                  return null;
                } else {
                  return v.isValidPassword;
                }
              }
              if (name == "Device ID") {
                if (v!.isValidDeviceId == "valid") {
                  return null;
                } else {
                  return v.isValidDeviceId;
                }
              }
              if (name == "OTP") {
                if (v!.isValidOTP == "valid") {
                  return null;
                } else {
                  return v.isValidOTP;
                }
              }
            },
            decoration: InputDecoration(
                prefixIcon: icon,
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    namecontroller.text = "";
                  },
                ),
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13),
                border: InputBorder.none,
                // fillColor: Colors.transparent,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }
}
