import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siadune/pages/notification_detail.dart';

class NotificationItem {
  NotificationItem({this.itemId});
  final String itemId;

  StreamController<NotificationItem> _controller =
      StreamController<NotificationItem>.broadcast();
  Stream<NotificationItem> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  String _type;
  String get type => _type;
  set type(String value) {
    _type = value;
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => NotificationDetail(itemId),
      ),
    );
  }
}

final Map<String, NotificationItem> notificationItems =
    <String, NotificationItem>{};
NotificationItem getNotificationItemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final NotificationItem item = notificationItems.putIfAbsent(
      itemId, () => NotificationItem(itemId: itemId))
    ..status = data['status']
    ..type=data['type'];
  return item;
}
