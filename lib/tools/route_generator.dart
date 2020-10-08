import 'package:flutter/material.dart';
import 'package:siadune/pages/notification_detail.dart';
import 'package:siadune/pages/order_details_page.dart';
import 'package:siadune/pages/register_user.dart';
import 'package:siadune/pages/signup_page.dart';
import '../models/goods.dart';
import '../models/store.dart';
import '../pages/login_page.dart';
import '../pages/product_details_page.dart';
import '../pages/splash_screen_page.dart';
import '../pages/store_details_page.dart';
// import 'package:routing_prep/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case '/storeDetails':
        // Validation of correct data type
        if (args is Store) {
          return MaterialPageRoute(
            builder: (_) => StoreDetailsPage(              
              currentStore: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute('پارامتر باید از نوع فروشگاه باشد.');
      case '/goodsDetails':
        // Validation of correct data type
        if (args is Goods) {
          // return MaterialPageRoute(
          //   builder: (_) => ProductDetailsPage(
          //     key: Key('goodsDetails_${args.id}'),
          //     goods: args,
          //   ),
          // );
          return _createRoute(ProductDetailsPage( key: Key('goodsDetails_${args.id}'), goods: args,));
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute('پارامتر باید از نوع کالا باشد');
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/notificationDetails':
         if (args is String) {
           return MaterialPageRoute(builder: (_)=> NotificationDetail(args));
         }  
           return _errorRoute('پارامتر باید از نوع نوتیفیکیشن باشد');   
            case '/orderDetails':
         if (args is String) {
           return MaterialPageRoute(builder: (_)=> OrderDetailsPage(args));
         }  
           return _errorRoute('پارامتر باید از نوع نوتیفیکیشن باشد');  
           case '/register':
             return MaterialPageRoute(builder: (_)=> SignUpScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute('مسیر ${settings.name} یافت نشد .');
    }
  }

  static Route<dynamic> _errorRoute([String errorText = '']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('خطا'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Column(
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.redAccent,
                  size: 80,
                ),
                Text(
                  'خطا در مسیریابی! \n ${errorText}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ],
            ))
          ],
        ),
      );
    });
  }
static Route _createRoute(Widget destinationPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


}
