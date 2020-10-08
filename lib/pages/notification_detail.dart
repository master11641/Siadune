import 'package:flutter/material.dart';
import 'dart:async';
import '../models/notification_item.dart';

class NotificationDetail extends StatefulWidget {
  NotificationDetail(this.itemId);
  final String itemId;
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  NotificationItem _item;
  StreamSubscription<NotificationItem> _subscription;

  @override
  void initState() {
    super.initState();
    _item = notificationItems[widget.itemId];
    _subscription = _item.onChanged.listen((NotificationItem item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" ${_item.itemId}"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10,right: 8,left: 8,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Text('${_item.status}',
                      style: Theme.of(context).textTheme.body1,textDirection: TextDirection.rtl,),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
