// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:login/components/appbar.dart';
import 'package:login/components/forms/unlock_form.dart';

class UnlockPage extends StatefulWidget {
  const UnlockPage({super.key});

  @override
  State<UnlockPage> createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  bool notification = false;
  late Widget notificationWidget;
  Duration animationDuration = const Duration(milliseconds: 270);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);
    return Scaffold(
      body: Stack(
        children: [
          UnlockForm(
            callback1: (val) => setState(() => notification = val),
            callback2: (widget) => setState(() => notificationWidget = widget),
            size: size,
            defaultLoginSize: defaultLoginSize,
          ),
          topBar(size, "Unlock Is Ready", context),
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
}
