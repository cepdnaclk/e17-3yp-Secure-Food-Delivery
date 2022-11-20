import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/components/constants.dart';
import 'package:login/components/fields/validators/validators.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.maxlen,
    required this.filter,
    required this.keyboardtype,
    required this.namecontroller,
  }) : super(key: key);

  final int maxlen;
  final String hint;
  final IconData icon;
  final TextInputType keyboardtype;
  final FilteringTextInputFormatter filter;
  final TextEditingController namecontroller;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hideCloseButton = true;

  @override
  void initState() {
    super.initState();
    if (widget.namecontroller.text != "") {
      hideCloseButton = false;
    }
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
          if (widget.hint == "Name") {
            if (v!.isValidName == "valid") {
              return null;
            } else {
              return v.isValidName;
            }
          }
          if (widget.hint == "Contact Number") {
            if (v!.isValidPhone == "valid") {
              return null;
            } else {
              return v.isValidPhone;
            }
          }
          if (widget.hint == "Email") {
            if (v!.isValidEmail == "valid") {
              return null;
            } else {
              return v.isValidEmail;
            }
          }
          if (widget.hint == "Address") {
            if (v!.isValidAddress == "valid") {
              return null;
            } else {
              return v.isValidAddress;
            }
          }
          if (widget.hint == "Device ID") {
            if (v!.isValidDeviceId == "valid") {
              return null;
            } else {
              return v.isValidDeviceId;
            }
          }
          return null;
        },
        onChanged: (text) {
          setState(() {
            hideCloseButton = widget.namecontroller.text == "" ? true : false;
          });
        },
        cursorColor: kPrimaryColor,
        keyboardType: widget.keyboardtype,
        inputFormatters: <TextInputFormatter>[widget.filter],
        maxLength: widget.maxlen,
        controller: widget.namecontroller,
        decoration: InputDecoration(
            icon: Icon(widget.icon, color: kPrimaryColor),
            counterText: "",
            suffixIcon: hideCloseButton
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        hideCloseButton = !hideCloseButton;
                        widget.namecontroller.text = "";
                      });
                    }),
            hintText: widget.hint,
            border: InputBorder.none),
      ),
    );
  }
}
