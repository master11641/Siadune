// import 'package:flutter/material.dart';
// import '../pages/adver_list.dart';
// import '../pages/store_list.dart';
// import '../widgets/drawer_widget.dart';

// class HomePage extends StatefulWidget {
//   HomePage();
//   static const Tag = "Tabbar";
//   List<Widget> screens = <Widget>[
//     StoreList(),
//   //  new Container(
//   //    color: Colors.black,
//   //  ),
//     AdverList(),
//   ];

//   @override
//   State<StatefulWidget> createState() {
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   int _currentIndex = 1;
//   Widget currentScreen;
//   @override
//   Widget build(BuildContext context) {
//     //var _l10n = PackedLocalizations.of(context);
//     debugPrintRebuildDirtyWidgets = false;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         leading: Builder(builder: (BuildContext context) {
//           return IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {},
//           );
//         }),
//         centerTitle: true,
//         title: Text("سیادونه"),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.line_style),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.grid_on),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () {
//               _scaffoldKey.currentState.openEndDrawer();
//             },
//           )
//         ],
//       ),
//       // appBar: AppBar(
//       //   title: Text("Drawer app"),
//       // ),
//       body: IndexedStack(
//         index: _currentIndex,
//         children: widget.screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.blueAccent,
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.format_list_bulleted),
//             title: new Text('فروشگاه ها'),
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.settings),
//             title: new Text('آگهی ها'),
//           )
//         ],
//       ),
//       endDrawer: DrawerWidget(key: Key('DrawerWidget'),),
//     );
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
