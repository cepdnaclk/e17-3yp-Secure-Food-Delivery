import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login/components/appbar.dart';
import 'package:login/components/card/notification/notification.dart';
import 'package:login/components/card/orders/order_card.dart';
import 'package:http/http.dart' as http;
import 'package:login/pages/login/login_rider.dart';
import 'package:login/pages/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool notification = false;
  final GlobalKey<FormState> _formKeyOrderList = GlobalKey<FormState>();
  late Widget notificationWidget;
  Duration animationDuration = const Duration(milliseconds: 270);
  var listData = [];

  @override
  void initState() {
    super.initState();
    _checkLoginRider();
    _getOrderList();
  }

  Future<http.Response> _getOrderList() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.setBool('login', true);
    List orderList;
    final response = await http.get(
      Uri.parse('https://20.235.78.254/api/order_handle/list'),
      headers: {'x-authtoken': riderToken.getString('riderToken').toString()},
    );
    if (response.statusCode == 200) {
      orderList = jsonDecode(response.body) as List;
      listData = orderList;
    }
    return response;
  }

  Future<http.Response> _confirmOrder(String orderid) async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    final url = 'https://20.235.78.254/api/order_handle/confirmed/' + orderid;
    final response = await http.get(
      Uri.parse('https://20.235.78.254/api/order_handle/confirmed/' + orderid),
      headers: {
        'x-authtoken': riderToken.getString('riderToken').toString(),
        "Content-Type": "application/json"
      },
    );
    return response;
  }

  _checkLoginRider() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    if (riderToken.getString("riderToken") == null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginRider()));
    }
  }

  clearToken() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.remove('riderToken');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              topBar(size, "ORDERS", context),
              const SizedBox(height: 10),
              Expanded(
                child: Form(
                  key: _formKeyOrderList,
                  child: FutureBuilder(
                    future: _getOrderList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return ListView.builder(
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return OrderCard(
                            size: size,
                            contact: listData[index]["mobNo"],
                            address: listData[index]["address"],
                            orderid: listData[index]["orderID"],
                            // contact: listData[index]["title"].substring(0, 10),
                            // address: listData[index]["title"].substring(0, 10),
                            // orderid: listData[index]["title"].substring(0, 10),
                            tap: () async {
                              try {
                                var response = await _confirmOrder(
                                    listData[index]['orderID']);
                                if (response.statusCode == 200) {
                                  setState(
                                    () {
                                      notification = true;
                                      notificationWidget = NotificationCard(
                                        body: response.body,
                                        onError: '',
                                        onSuccess: 'OK',
                                        title: 'Confirmed Successfully',
                                        typeIsSingle: true,
                                        tapBack: () {},
                                        tapNext: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WelcomePage(),
                                            ),
                                          );
                                          setState(() {
                                            notification = false;
                                          });
                                        },
                                      );
                                    },
                                  );
                                } else if (response.statusCode == 400) {
                                  setState(
                                    () {
                                      notification = true;
                                      notificationWidget = NotificationCard(
                                        body: "Incorrect Credentials",
                                        onError: 'Back',
                                        onSuccess: 'Home',
                                        title: 'Incorrect Order',
                                        typeIsSingle: false,
                                        tapBack: () {
                                          setState(() {
                                            notification = false;
                                          });
                                        },
                                        tapNext: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WelcomePage(),
                                            ),
                                          );
                                          setState(() {
                                            notification = false;
                                          });
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  setState(
                                    () {
                                      notification = true;
                                      notificationWidget = NotificationCard(
                                        body: "",
                                        onError: '',
                                        onSuccess: 'Try Again',
                                        title: 'Something Went Wrong',
                                        typeIsSingle: true,
                                        tapBack: () {},
                                        tapNext: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderList(),
                                            ),
                                          );
                                          setState(() {
                                            notification = false;
                                          });
                                        },
                                      );
                                    },
                                  );
                                }
                              } on TimeoutException catch (e) {
                                setState(() {
                                  notification = true;
                                  notificationWidget = NotificationCard(
                                    body:
                                        'Check Your Connection \n and\n try again',
                                    onError: '',
                                    onSuccess: 'OK',
                                    title: 'Connection Error!',
                                    typeIsSingle: true,
                                    tapBack: () {},
                                    tapNext: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderList(),
                                        ),
                                      );
                                      setState(() {
                                        notification = false;
                                      });
                                    },
                                  );
                                });
                              } catch (e) {
                                notification = true;
                                notificationWidget = NotificationCard(
                                  body: e.toString(),
                                  onError: '',
                                  onSuccess: 'OK',
                                  title: 'Connection Error!',
                                  typeIsSingle: true,
                                  tapBack: () {},
                                  tapNext: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OrderList(),
                                      ),
                                    );
                                    setState(() {
                                      notification = false;
                                    });
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          if (notification)
            AnimatedOpacity(
              duration: animationDuration,
              opacity: 0.5,
              child: const Scaffold(),
            ),
          if (notification) notificationWidget
        ],
      ),
    );
  }
}
