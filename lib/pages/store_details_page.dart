import 'package:flutter/material.dart';
import '../blocs/goods_bloc.dart';
import '../models/goods.dart';
import '../models/store.dart';
import '../widgets/photo_scroller.dart';
import '../widgets/store_details_header.dart';

class StoreDetailsPage extends StatefulWidget {
  StoreDetailsPage({this.currentStore}) : super();
  final Store currentStore;

  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  GoodsBloc goodsBloc;
  @override
  void initState() {
    //super.initState();
    goodsBloc = new GoodsBloc();
    goodsBloc.storeId = widget.currentStore.id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //  tag: Key('store_${widget.currentStore.id}'),
        child: WillPopScope(
      onWillPop: () {
        // showAlert(context, 'input');
       // goodsBloc.clearPages();
       // goodsBloc.dispose();
        this.dispose();
        // this.dispose();
        Navigator.pop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: false,
                expandedHeight: 350,
                pinned: true,
                //  title:  Text(widget.currentStore.title,style: TextStyle(color: Colors.black54),),
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: StoreDetailsHeader(widget.currentStore),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<List<Goods>>(
                          stream: goodsBloc.outMainList,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Goods>> snapshot) {
                            return Container(
                              child: snapshot.data == null
                                  ? _buildPhotoScroller(context, [], goodsBloc)
                                  : _buildPhotoScroller(
                                      context,
                                      snapshot.data
                                          .where(
                                              (f) => f.tgoodsImages.length != 0)
                                          // .map((x) => x.tgoodsImages.first.imageUrl)
                                          .toList(),
                                      goodsBloc),
                            );
                          }),
                      // SizedBox(height: 20.0),
                      // PhotoCircleScroller({
                      //   'https://dkstatics-public.digikala.com/digikala-products/111046027.jpg?x-oss-process=image/resize,h_800/quality,q_80':
                      //       'موبایل'
                      // }),
                      // SizedBox(
                      //   height: 20,
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildPhotoScroller(
      BuildContext context, List<Goods> goods, GoodsBloc goodsBloc) {
    PhotoScroller scroller = PhotoScroller(goods, goodsBloc);
    scroller.indexCounterSubject.stream
        .listen((index) => {goodsBloc.inAdverIndex.add(index)});
    return scroller;
  }
}
