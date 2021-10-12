import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'WelcomePage.dart';
import 'Widget/appbar.dart';
import 'loginPageRider.dart';
import 'Widget/bezierContainer.dart';

class OrderList extends StatefulWidget {
  OrderList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var listData = [];

  @override
  void initState() {
    super.initState();
    _checkLoginRider();
    _getOrderList();
  }

  Future _getOrderList() async {
    var orderList;
    try {
      final response = await get(
        Uri.parse('https://35.171.26.170/api/order_handle/list'),
        headers: {'x-authtoken': getToken()},
      );

      if (response.statusCode == 200) {
        orderList = jsonDecode(response.body) as List;
        listData = orderList;
      }
      print(response.statusCode);
      print(response.body);
      return response.statusCode;
    } catch (err) {}
  }

  Future _confirmOrder(String orderid) async {
    try {
      final response = await post(
          Uri.parse(
              'https://35.171.26.170/api/order_handle/confirmed/' + orderid),
          headers: {'x-authtoken': getToken()},
          body: {'orderid': orderid});

      print(response.statusCode);
      print(response.body);
      return response.statusCode;
    } catch (err) {}
  }

  _checkLoginRider() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    if (riderToken.getString("riderToken") == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPageRider(title: '')));
    }
  }

  getToken() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    String? token = riderToken.getString('riderToken');
    return token;
  }

  clearToken() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.remove('riderToken');
  }

  Widget _orderList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index) {
        final item = listData[index];
        return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                //color: Color.fromRGBO(64, 75, 96, .9),
                //borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.black))),
                    child: Icon(Icons.delivery_dining, color: Colors.black),
                  ),
                  title: Text(item["title"],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Row(
                    children: <Widget>[
                      // Icon(Icons.linear_scale, color: Colors.blue.shade900),
                      Text(item["title"][0],
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () async {
                      var statusCode = await _confirmOrder(item['title']);
                      if (statusCode == 201) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title:
                                        const Text('Confirmed Successfully!!!'),
                                    // content: const Text(''),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderList(title: ''))),
                                        child: const Text('Ok'),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            clearToken();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WelcomePage(
                                                            title: '')));
                                          },
                                          child: const Text('Go to Main Page'))
                                    ]));
                      } else if (statusCode == 400) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Incorrect Order!!!'),
                            // content: const Text('Incorrect Credentials'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderList(title: ''))),
                                child: const Text('Ok'),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderList(title: '')));
                    },
                    color: Colors.black,
                  )),
            ));
      },
    );
  }

  Widget _orderConfirm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: Text(
        'Order Arrived',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: Appbar(subtitle: "Orders"),
        body: SafeArea(
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: _orderList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
