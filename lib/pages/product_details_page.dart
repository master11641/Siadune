import 'dart:core';
import 'package:flutter/material.dart';

// import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:rxdart/subjects.dart';
import 'package:siadune/api/account_api.dart';
import 'package:siadune/api/order_api.dart';
import 'package:siadune/app_setting_data/colors.dart';
import 'package:siadune/blocs/bloc_provider.dart';
import 'package:siadune/blocs/user_bloc.dart';
import 'package:siadune/pages/map_ui_page.dart';
import 'package:siadune/models/order_details.dart' as order;
import '../models/goods.dart';
import '../tools/common_funcs.dart';
import '../tools/extends.dart';
import '../tools/preferences.dart';
import '../widgets/product_details_header.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key key, this.goods}) : super(key: key);
  final Goods goods;
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  PublishSubject<bool> addToBasketClicked = PublishSubject<bool>();
  List<int> selectedAttributeValueIds = new List<int>();
  List<int> selectedAttributeIds = new List<int>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int addressId = 0;
  Size size;
  // LocationResult _pickedLocation;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Builder(
              builder: (context) => Container(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: 5, right: 10, left: 10, bottom: 5),
                                child: ProductDetailsHeader(
                                  key: widget.key,
                                  goods: widget.goods,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 5, right: 10, left: 10, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          15,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border:
                                          //     new Border.all(color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                            )
                                          ]),
                                      child: Text(
                                        'نظرات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: Preferences.fontName),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          15,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border:
                                          //     new Border.all(color: Colors.grey),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                            )
                                          ]),
                                      child: Text(
                                        'مشخصات',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: Preferences.fontName),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 5, right: 10, left: 10, bottom: 5),
                                child: Card(
                                  elevation: 2.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: widget.goods.attributes
                                                .map((f) =>
                                                    _buildAttributeSelect(f))
                                                .toList()),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.shop,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              ' فروش توسط ${widget.goods.storeTitle}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      Preferences.fontName,
                                                  fontSize: 14,
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                        VerticalDivider(
                                          color: Colors.red,
                                          width: double.infinity,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.transfer_within_a_station,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              ' حمل رایگان دارد',
                                              style: TextStyle(
                                                  fontFamily:
                                                      Preferences.fontName,
                                                  fontSize: 14,
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          // ' ${(FlutterMoneyFormatter(amount: widget.goods.price)).output.withoutFractionDigits} تومان',
                                          //  intl.NumberFormat("###,0#", "en_US").format(widget.goods.price),
                                          'قیمت ' +
                                              widget.goods.price
                                                  .toInt()
                                                  .toString() +
                                              ' تومان',
                                          style: TextStyle(
                                              color: CustomColor.primaryColor,
                                              fontFamily: Preferences.fontName,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                  left: 0.0,
                                                  right: 0.0),
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                    color: CustomColor
                                                        .primaryColor,
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            const Radius
                                                                    .circular(
                                                                2.0))),
                                                height: 50.0,
                                                width: double
                                                    .infinity, // match_parent
                                                child: new Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.shopping_cart,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      new Text(
                                                        "ثبت سفارش",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                Preferences
                                                                    .fontName,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                          onTap: () async {
                                            List<int> mustSelectId = widget
                                                .goods.attributes
                                                .where(
                                                    (f) => f.required == true)
                                                .map((f) => f.attributeId)
                                                .toList();
                                            bool formIsValid =
                                                mustSelectId.every((x) =>
                                                    selectedAttributeIds
                                                        .contains(x));
                                            if (formIsValid) {
                                              // addToBasketClicked.sink.add(false);
                                              var userApi =
                                                  await accountApi.getUser();

                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 50,
                                                                bottom: 100,
                                                                right: 15,
                                                                left: 15),
                                                        child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: Colors.white,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'انتخاب آدرس',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5
                                                                            .copyWith(color: Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  height: 50,
                                                                  decoration: BoxDecoration(
                                                                      color: CustomColor
                                                                          .primaryColor
                                                                      // gradient:
                                                                      //     CustomColor
                                                                      //         .primaryGradiant,
                                                                      ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      ListView(
                                                                    children: _buildAddressItems(
                                                                        userApi
                                                                            .customerOrderAddress),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .all(3),
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    color: CustomColor
                                                                        .primaryColor,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          'بر اساس جی پی اس ارسال شود',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline5
                                                                              .copyWith(color: Colors.white),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    showPlacePicker();
                                                                  },
                                                                )
                                                              ],
                                                            )),
                                                      ),
                                                    );
                                                  });

                                              //showPlacePicker();
                                              //گرفتن طول و عرض جغرافیایی
                                              // LocationResult result =
                                              //     await LocationPicker
                                              //         .pickLocation(
                                              //   context,
                                              //   "AIzaSyAtHmfRlndPSPz6TLVAkngqbN7NkoEJ42Y",
                                              // );
                                              // print("result = $result");
                                            } else {
                                              addToBasketClicked.sink.add(true);
                                              showSnackBar(
                                                  context,
                                                  'تمامی ویژگی ها را انتخاب نمایید',
                                                  Colors.red);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    top: 5, right: 10, left: 10, bottom: 5),
                                child: Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        widget.goods.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(color: Color(0xFFf2f2f2)),
                  )),
        ));
  }

  void _sendOrder() {
    orderApi
        .registerOrder(widget.goods.id, 1, addressId, selectedAttributeValueIds)
        .catchError((er) {
      //showSnackBar(context, er.toString(), Colors.red);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(er.toString()),
      ));
    }).then((x) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('سفارش با موفقیت ثبت شد'),
      ));
    });
  }

  Widget _buildAttributeSelect(Attributes attr) {
    switch (attr.tattributeType) {
      case 0:
        return StreamBuilder(
          stream: addToBasketClicked.stream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${attr.name}',
                    style: TextStyle(
                        fontFamily: Preferences.fontName, color: Colors.black),
                    textDirection: TextDirection.rtl,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildColorBoxes(attr.attributeValues, attr),
                  ),
                ],
              ),
              //در صورتی که ویژگی انتخاب آن ضروری باشد و کاربر
              //هیچ مقداری از آن را انتخاب نکرده باشد به محض کلیک
              // روی دکمه ثبت سفارش حاشیه به رنگ قرمز خواهد شد
              decoration: BoxDecoration(
                border: (snapshot.data == true &&
                        selectedAttributeIds.indexOf(attr.attributeId) == -1 &&
                        attr.required == true)
                    ? Border.all(color: Colors.red)
                    : Border.all(color: Colors.transparent),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  void showPlacePicker() async {
    // LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) =>
    //         PlacePicker("AIzaSyAtHmfRlndPSPz6TLVAkngqbN7NkoEJ42Y")));

    // // Handle the result in your way
    // print(result);
    //final LatLng center = const LatLng(35.708329, 51.409836);
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //         body: SafeArea(
    //           child: Container(),
    //         ))));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
                body: SafeArea(
              child: MapUiBody(),
            ))
            ));
  }

  List<Widget> _buildAddressItems(List<order.CustomerOrderAddress> addresses) {
    return addresses
        .map((x) => Card(
              elevation: 10,
              child: ListTile(
                title: Text(
                  x.fullAddress,
                  style: Theme.of(context).textTheme.bodyText2,
                  textDirection: TextDirection.rtl,
                ),
                leading: Icon(
                  Icons.location_on,
                  color: CustomColor.primaryColor,
                ),
                onTap: () {
                  addressId = x.addressId;
                  Navigator.of(context).pop();
                  _sendOrder();
                },
              ),
            ))
        .toList();
  }

  List<Widget> _buildColorBoxes(
      List<AttributeValues> values, Attributes attributes) {
    return values
        .map((f) => GestureDetector(
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(right: 4.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: HexColor('${f.value}'),
                        radius: 8,
                      ),
                      Text(
                        '${f.caption}',
                        style: TextStyle(
                            fontFamily: Preferences.fontName,
                            fontSize: 10,
                            color:
                                (selectedAttributeValueIds.indexOf(f.valueId) !=
                                        -1)
                                    ? Colors.white
                                    : Colors.grey),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: (selectedAttributeValueIds.indexOf(f.valueId) != -1)
                        ? HexColor('${f.value}')
                        : Colors.white,
                    border: (selectedAttributeValueIds.indexOf(f.valueId) != -1)
                        ? Border.all(
                            color: Colors.green, style: BorderStyle.solid)
                        : Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              onTap: () {
                if (selectedAttributeIds.indexOf(attributes.attributeId) ==
                    -1) {
                  selectedAttributeIds.add(attributes.attributeId);
                }
                for (int i = 0; i < values.length; i++) {
                  if (selectedAttributeValueIds.indexOf(values[i].valueId) !=
                      -1) {
                    selectedAttributeValueIds.remove(values[i].valueId);
                  }
                }
                setState(() {
                  selectedAttributeValueIds.add(f.valueId);
                });
              },
            ))
        .toList();
  }
}
