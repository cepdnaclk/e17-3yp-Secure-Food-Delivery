import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/components/constants.dart';
import 'package:login/components/fields/validators/validators.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.hint,
    required this.maxlen,
    required this.filter,
    required this.keyboardtype,
    required this.namecontroller,
  }) : super(key: key);

  final int maxlen;
  final String hint;
  final TextInputType keyboardtype;
  final FilteringTextInputFormatter filter;
  final TextEditingController namecontroller;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPassword = true;
  bool isIconVisible = false;

  void toggle() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isPassword = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withAlpha(50),
      ),
      child: TextFormField(
        validator: (v) {
          if (widget.hint == "Order ID") {
            if (v!.isValidOrderId == "valid") {
              return null;
            } else {
              return v.isValidOrderId;
            }
          }
          if (widget.hint == "Password") {
            if (v!.isValidPassword == "valid") {
              return null;
            } else {
              return v.isValidPassword;
            }
          }
          if (widget.hint == "OTP") {
            if (v!.isValidOTP == "valid") {
              return null;
            } else {
              return v.isValidOTP;
            }
          }
          return null;
        },
        onChanged: (text) {
          setState(() {
            isIconVisible = widget.namecontroller.text == "" ? false : true;
          });
        },
        cursorColor: kPrimaryColor,
        obscureText: isPassword,
        keyboardType: widget.keyboardtype,
        inputFormatters: <TextInputFormatter>[widget.filter],
        maxLength: widget.maxlen,
        controller: widget.namecontroller,
        decoration: InputDecoration(
            icon: const Icon(Icons.lock, color: kPrimaryColor),
            counterText: "",
            suffixIcon: isIconVisible
                ? IconButton(
                    icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                        toggle();
                      });
                    })
                : null,
            hintText: widget.hint,
            border: InputBorder.none),
      ),
    );
  }
}
