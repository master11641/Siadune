import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:siadune/app_setting_data/colors.dart';
import 'package:siadune/blocs/goods_bloc.dart';
import 'package:siadune/blocs/store_bloc.dart';
import '../models/goods.dart';
import '../tools/preferences.dart';

class PhotoScroller extends StatefulWidget {
  PhotoScroller(this.goods, this._goodsBloc);
  // final List<String> photoUrls;
  final GoodsBloc _goodsBloc;
  final List<Goods> goods;
  BehaviorSubject<int> indexCounterSubject = BehaviorSubject<int>.seeded(0);
  @override
  _PhotoScrollerState createState() => _PhotoScrollerState();
}

class _PhotoScrollerState extends State<PhotoScroller> {
  @override
  void dispose() async {
    widget.indexCounterSubject.close();
    super.dispose();
  }

  Widget _buildPhoto(BuildContext context, int index) {
    widget.indexCounterSubject.sink.add(index);
    // var photo =(widget.photoUrls.length!=0) ? widget.photoUrls[index] : "";
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: widget.goods.length - 1 < index
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: 190,
                  height: 220,
                  child: Card(
                      elevation: 8.0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                widget.goods[index].tgoodsImages.first.imageUrl,
                                width: 160.0,
                                height: 140.0,
                                // fit: BoxFit.contain,
                              ),
                            ),
                            Center(
                                child: Container(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                '${widget.goods[index].title.substring(0, min(widget.goods[index].title.length, 50))}',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontFamily: Preferences.fontName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  //' ${(FlutterMoneyFormatter(amount: widget.goods[index].price)).output.withoutFractionDigits} تومان',
                                  widget.goods[index].price.toInt().toString()+'  تومان',
                                  // NumberFormat('###,000', 'zz').format(widget.goods[index].price),
                                  //intl.NumberFormat("###,0#", "en_US").format(widget.goods[index].price),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: CustomColor.primaryColor,
                                      ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )),
                ),
        ),
      ),
      onTap: () => {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (BuildContext context) {
        //   return ProductDetailsPage(
        //     key: Key('goodsDetails_${widget.goods[index].id}'),
        //     goods: widget.goods[index],
        //   );
        // })),
        Navigator.of(context)
            .pushNamed('/goodsDetails', arguments: widget.goods[index])
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'محصولات',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: CustomColor.primaryColor),
            )),
        SizedBox.fromSize(
          size: const Size.fromHeight(300.0),
          child: ListView.builder(
            itemCount: widget._goodsBloc.doesStoreFetchEnded()
                ? widget.goods.length + 5
                : widget.goods.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: _buildPhoto,
          ),
        ),
      ],
    );
  }
}
