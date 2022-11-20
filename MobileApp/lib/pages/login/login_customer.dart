import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/components/forms/components/cancel_button.dart';
import 'package:login/components/constants.dart';
import 'package:login/components/forms/login_form_customer.dart';
import 'package:login/components/forms/register_form_customer.dart';
import 'package:login/components/appbar.dart';

class LoginCustomer extends StatefulWidget {
  const LoginCustomer({super.key});

  @override
  State<LoginCustomer> createState() => _LoginCustomerState();
}

class _LoginCustomerState extends State<LoginCustomer>
    with SingleTickerProviderStateMixin {
  bool notification = false;
  bool isLogin = true;
  late Widget notificationWidget;
  late final String type;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //to determine whether the keyboard is opened
    double viewInset = MediaQuery.of(context).viewInsets.bottom;

    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(
            begin: size.height * 0.1, end: defaultRegisterSize)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        children: [
          //Login Form
          LoginFormCustomer(
            isLogin: isLogin,
            animationDuration: animationDuration * 5,
            size: size,
            defaultLoginSize: defaultLoginSize,
            callback1: (val) => setState(() => notification = val),
            callback2: (widget) => setState(() => notificationWidget = widget),
          ),
          //AppBar
          topBar(size, "Welcome Back", context),

          //Cancel Button
          CancelButton(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            animationController: animationController,
            tapEvent: isLogin
                ? null
                : () {
                    animationController.reverse();
                    setState(
                      () {
                        isLogin = !isLogin;
                      },
                    );
                  },
          ),

          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (viewInset == 0 && isLogin) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }
              return Container();
            },
          ),

          //Register_form
          RegisterFormCustomer(
            isLogin: isLogin,
            animationDuration: animationDuration * 5,
            size: size,
            defaultLoginSize: defaultLoginSize,
            callback1: (val) => setState(() => notification = val),
            callback2: (widget) => setState(() => notificationWidget = widget),
          ),

          if (notification)
            AnimatedOpacity(
              duration: animationDuration,
              opacity: 0.5,
              child: const Scaffold(),
            ),
          if (notification) notificationWidget,
        ],
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: kBackgroundColor,
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin
              ? null
              : () {
                  animationController.forward();
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
          child: isLogin
              ? const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
