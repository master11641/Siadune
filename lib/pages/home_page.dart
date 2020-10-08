import 'package:bubble_animated_tabbar/bubble_animated_tabbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:siadune/app_setting_data/colors.dart';
import 'package:siadune/models/notification_item.dart';
import 'package:siadune/pages/stores_categorized.dart';
import '../pages/store_list.dart';
import '../widgets/drawer_widget.dart';

String pushMessagingToken = '';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    int _currentIndex = 0;
  TabController tabController;
  List<Map> children = [
    {
      'icon': Icons.store,
      'title': 'فروشگاه ها',
      'iconSize': 23,
      'color': CustomColor.primaryColor,
      'textColor': Colors.white,
     // 'customTextStyle': TextStyle(color: Color.fromRGBO(173, 118, 23, 1)),
      'tabPadding' : EdgeInsets.fromLTRB(10, 10, 10, 10)
    },
    {
      'icon': Icons.shopping_basket,
      'title': 'سفارشات',
      'color': CustomColor.primaryColor,
      'textColor': Colors.white,
      'tabPadding' : EdgeInsets.fromLTRB(10, 10, 10, 10)
    },
    {
      'icon': Icons.email,
      'title': 'پیام ها',
      'color': CustomColor.primaryColor,
      'textColor': Colors.white,
      'tabPadding' : EdgeInsets.fromLTRB(10, 10, 10, 10)
    },
        {
      'icon': Icons.settings,
      'title': 'تنظیمات',
      'color': CustomColor.primaryColor,
      'textColor': Colors.white,
      'tabPadding' : EdgeInsets.fromLTRB(10, 10, 10, 10)
    },
  ];
  getBoxDecoration() {
    return BoxDecoration(color: Colors.white, boxShadow: [
      new BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 1.0,
          spreadRadius: 1.0)
    ]);
  }

  onTabViewChange() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }
    void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      tabController.animateTo(index);
    });
  }
  Widget _buildDialog(BuildContext context, NotificationItem item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) =>
          _buildDialog(context, getNotificationItemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final NotificationItem item = getNotificationItemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Future.delayed(Duration.zero, () {
        // Navigator.push(context, item.route);
        switch (item.type) {
          case 'order':
            Navigator.of(context).pushNamed(
              '/orderDetails',
              arguments: item.itemId,
            );
            break;
          default:
            Navigator.of(context).pushNamed(
              '/notificationDetails',
              arguments: item.itemId,
            );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(vsync: this, initialIndex: 0, length: children.length);
    tabController.addListener(onTabViewChange);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      // onBackgroundMessage: (Map<String, dynamic> message) async {
      //   if (message.containsKey('data')) {
      //     // Handle data message
      //     final dynamic data = message['data'];
      //   }

      //   if (message.containsKey('notification')) {
      //     // Handle notification message
      //     final dynamic notification = message['notification'];
      //   }

      //   // Or do other work.
      // },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      pushMessagingToken = token;
      // setState(() {
      // _homeScreenText = "Push Messaging token: $token";
      // });
      print('Push Messaging token: $token');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.black12,
       title: Center(child: Text('سیـادونه',style: Theme.of(context).textTheme.headline5.copyWith(color: CustomColor.primaryColor),)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      // body: StoreCategorized(),
      body: TabBarView(
        children: [StoreCategorized(), StoreCategorized(), StoreCategorized(),StoreCategorized()],
        controller: tabController,
      ),
      drawer: DrawerWidget(
        key: Key('DrawerWidget'),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: AnimatedTabbar(
        //  padding: EdgeInsets.only(left: 4, top: 6, right: 4, bottom: 6),
          containerDecoration: getBoxDecoration(),
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          children: children,
        ),
      ),
    ));
  }
}
