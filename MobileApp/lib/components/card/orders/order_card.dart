import 'package:flutter/material.dart';
import 'package:login/components/card/orders/confirm_button.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key? key,
    required this.size,
    required this.contact,
    required this.address,
    required this.orderid,
    required this.tap,
  }) : super(key: key);

  final GestureTapCallback tap;
  final Size size;
  final String contact;
  final String address;
  final String orderid;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool activateButton = false;

  @override
  void initState() {
    super.initState();
    activateButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.size.width * .025, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 13, 1, 80).withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(4, 4))
          ],
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 13, 1, 80),
              Color.fromARGB(255, 51, 88, 108)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.label,
                      color: Colors.white,
                      size: 25,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.contact,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'avenir'),
                    ),
                  ],
                ),
                Switch(
                  value: activateButton,
                  onChanged: (bool value) {
                    setState(() {
                      activateButton = !activateButton;
                    });
                  },
                  activeColor: Colors.white,
                )
              ],
            ),
            Text(
              widget.address,
              style: const TextStyle(color: Colors.white, fontFamily: 'avenir'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.orderid,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'avenir',
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                activateButton
                    ? ConfirmButton(
                        tap: activateButton ? widget.tap : () {},
                        width: widget.size.width * .85)
                    : const SizedBox(
                        height: 43,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
