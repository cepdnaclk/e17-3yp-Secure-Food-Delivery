import 'package:flutter/material.dart';

import '../WelcomePage.dart';
import '../orderList.dart';

class DialogBox {
  DialogBox(
    this.context,
    this.title,
    this.content,
    this.forward,
    this.backward,
    this.pagenext,
    // this.pageback,
  );

  final BuildContext context;
  final String title;
  final String content;
  final String forward;
  final String backward;
  final String pagenext;
  // final String pageback;

  var pageNext;
  var pageBack;

  getPageNext() {
    if (pagenext == "welcome") {
      pageNext = WelcomePage(title: '');
    }
    return pageNext;
  }

  // getPageBack() {
  //   if (pageback == "orderlist") {
  //     pageBack = OrderList(title: '');
  //   }
  //   return pageBack;
  // }

  showDialogBox() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(backward),
          ),
          TextButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => getPageNext())),
            child: Text(forward),
          ),
        ],
      ),
    );
  }
}
