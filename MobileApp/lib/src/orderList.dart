import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'WelcomePage.dart';
import 'Widget/appbarrider.dart';
import 'Widget/submitbutton.dart';
import 'loginPageRider.dart';
import 'Widget/bezierContainer.dart';

class OrderList extends StatefulWidget {
  OrderList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final GlobalKey<FormState> _formKeyOrderList = GlobalKey<FormState>();
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
    var orderList;
    final response = await http.get(
      Uri.parse('https://35.171.26.170/api/order_handle/list'),
      headers: {'x-authtoken': riderToken.getString('riderToken').toString()},
    );
    print(riderToken.getString('riderToken').toString());
    if (response.statusCode == 200) {
      orderList = jsonDecode(response.body) as List;
      listData = orderList;
      print(listData);
      print(riderToken.getString('riderToken').toString());
    }
    print(response.statusCode);
    print(response.body);
    return response;
  }

  Future<http.Response> _confirmOrder(String orderid) async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    final url = 'https://35.171.26.170/api/order_handle/confirmed/' + orderid;
    final response = await http.get(
      Uri.parse('https://35.171.26.170/api/order_handle/confirmed/' + orderid),
      headers: {
        'x-authtoken': riderToken.getString('riderToken').toString(),
        "Content-Type": "application/json"
      },
    );
    print(url);
    print(response.statusCode);
    print(response.body);
    return response;
  }

  _checkLoginRider() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    if (riderToken.getString("riderToken") == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPageRider(title: '')));
    }
  }

  // getToken() async {
  //   SharedPreferences riderToken = await SharedPreferences.getInstance();
  //   String? token = riderToken.getString('riderToken');
  //   return token;
  // }

  clearToken() async {
    SharedPreferences riderToken = await SharedPreferences.getInstance();
    riderToken.remove('riderToken');
  }

  Widget _refresh() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderList(title: ''),
                ),
              );
            },
            child: SubmitButton(buttontext: "Refresh")));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppbarRider(
          subtitle: "Orders",
          previous: "regrider",
        ),
        // body: Safearea(formkey: _formKeyOrderList, body: _widget()),
        // body: SafeArea(
        //   child: Container(
        //     height: height,
        //     child: Stack(
        //       children: <Widget>[
        //         Positioned(
        //           top: -MediaQuery.of(context).size.height * .15,
        //           right: -MediaQuery.of(context).size.width * .4,
        //           child: BezierContainer(),
        //         ),
        //         Container(
        //           padding: EdgeInsets.symmetric(horizontal: 30),
        //           child: SingleChildScrollView(
        //             scrollDirection: Axis.vertical,
        //             child: Form(
        //               key: _formKeyOrderList,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
        //                   SizedBox(height: 20),
        //                   _refresh(),
        //                   SizedBox(height: 20),
        //                   _orderList()
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )

        body: Stack(children: <Widget>[
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: BezierContainer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Form(
              key: _formKeyOrderList,
              child: FutureBuilder(
                future: _getOrderList(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        child: Container(
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0, color: Colors.black))),
                                child: Icon(Icons.delivery_dining,
                                    color: Colors.black),
                              ),
                              title: Text(listData[index]["orderID"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                listData[index]["mobNo"] +
                                    "\n" +
                                    listData[index]["address"],
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.keyboard_arrow_right),
                                onPressed: () async {
                                  var response = await _confirmOrder(
                                      listData[index]['orderID']);
                                  if (response.statusCode == 200) {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: const Text(
                                                    'Confirmed Successfully!!!'),
                                                content: Text(response.body),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrderList(
                                                                    title:
                                                                        ''))),
                                                    child: const Text('Ok'),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    WelcomePage(
                                                                        title:
                                                                            '')));
                                                      },
                                                      child: const Text(
                                                          'Go to Main Page'))
                                                ]));
                                  } else if (response.statusCode == 400) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
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
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'Something Went Wrong!!!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Try Again'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderList(title: '')));
                                },
                                color: Colors.black,
                              )),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
