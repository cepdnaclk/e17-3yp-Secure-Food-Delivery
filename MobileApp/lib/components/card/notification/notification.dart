import 'package:flutter/material.dart';
import 'package:login/components/card/notification/notification_card_button.dart';
import 'package:login/components/constants.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard(
      {super.key,
      required this.title,
      required this.typeIsSingle,
      required this.body,
      required this.onSuccess,
      required this.onError,
      required this.tapNext,
      required this.tapBack});

  final String title;
  final bool typeIsSingle;
  final String body;
  final String onSuccess;
  final String onError;
  final GestureTapCallback tapNext;
  final GestureTapCallback tapBack;
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              width: size.width * .75,
              // height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      blurRadius: 20.0,
                      spreadRadius: 1000.0,
                      offset: const Offset(2, 2))
                ],
              ),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: kPrimaryColor,
                  thickness: 1.5,
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    widget.body,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kTextColor,
                      // fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                widget.typeIsSingle
                    ? NotificationCardButton(
                        onSubmit: widget.onSuccess, tap: widget.tapNext)
                    : IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: NotificationCardButton(
                                onSubmit: widget.onError,
                                tap: widget.tapBack,
                              ),
                            ),
                            // const VerticalDivider(
                            //   width: 0,
                            //   indent: 12.5,
                            //   endIndent: 10,
                            //   color: kPrimaryColor,
                            //   thickness: 1.5,
                            // ),
                            Expanded(
                              child: NotificationCardButton(
                                onSubmit: widget.onSuccess,
                                tap: widget.tapNext,
                              ),
                            ),
                          ],
                        ),
                      ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
