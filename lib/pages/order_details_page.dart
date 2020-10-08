import 'dart:async';

import 'package:flutter/material.dart';
import 'package:siadune/api/order_api.dart';
import 'package:siadune/models/order_details.dart';
import '../models/notification_item.dart';

class OrderDetailsPage extends StatefulWidget {
  final String itemId;
  OrderDetailsPage(this.itemId);
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetailsPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" سفارش جدید"),
      ),
      body: Container(
          width: double.infinity,
          color: Colors.black12,
          padding: EdgeInsets.only(top: 15, bottom: 15, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                  elevation: 8.0,
                  margin: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FutureBuilder<OrderDetails>(
                        future: orderApi.getOrderById(_item.itemId),
                        initialData: OrderDetails(
                            id: 0,
                            userMobile: '',
                            userFullName: '',                           
                            goodsId: 0,
                            goodsTitle: '',
                            goodsImage: '',
                            attributes: null,
                            torderStatus: 0),
                        builder:
                            (BuildContext context, AsyncSnapshot<OrderDetails> snapshot) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Image.network(
                                  '${snapshot.data.goodsImage}',
                                  width: 100,
                                  height: 120,
                                ),
                                Text(
                                  'نام و نام خانوادگی : ${snapshot.data.userFullName}',
                                  style: Theme.of(context).textTheme.body1,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'شماره تماس : ${snapshot.data.userMobile}',
                                  style: Theme.of(context).textTheme.body1,
                                  textDirection: TextDirection.rtl,
                                ),
                               // Text('آدرس : ${snapshot.data.address}',textDirection: TextDirection.rtl,),
                                Text('نام کالا : ${snapshot.data.goodsTitle}',textDirection: TextDirection.rtl,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _buildAttributeText(snapshot.data.attributes),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ))
            ],
          )),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: <Widget>[
      //     Container(

      //       child: Row(
      //         children: <Widget>[
      //           FutureBuilder<OrderDetails>(
      //             future: orderApi.getOrderById(_item.itemId),
      //             initialData: OrderDetails(
      //                 id: 0,
      //                 userMobile: '',
      //                 userFullName: '',
      //                 address: '',
      //                 goodsId: 0,
      //                 goodsTitle: '',
      //                 goodsImage: '',
      //                 torderStatus: 0),
      //             builder: (BuildContext context, AsyncSnapshot snapshot) {
      //               return Container(
      //                 color: Colors.blue,
      //                 padding: EdgeInsets.only(top:5,bottom: 5,right: 20,left: 20),
      //               );
      //             },
      //           ),
      //           Container(
      //                 width: double.infinity,
      //                 color: Colors.blue,
      //                 padding: EdgeInsets.only(top:5,bottom: 5,right: 20,left: 20),),

      //         ],
      //       ),
      //     )
      //   ],
      // )
    );
  }

  List<Widget> _buildAttributeText(List<Attributes> attrs) {
   return attrs.map((x) => Text('${x.name+ " : "+x.caption} ' )).toList();
  }
}
