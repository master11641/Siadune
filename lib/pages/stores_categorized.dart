import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:siadune/api/category_api.dart';
import 'package:siadune/blocs/store_bloc.dart';
import 'package:siadune/blocs/store_categorized_bloc.dart';
import 'package:siadune/components/Section.dart';
import 'package:siadune/models/category.dart';
import 'package:siadune/models/store.dart';

class StoreCategorized extends StatefulWidget {
  StoreCategorized({Key key}) : super(key: key);

  @override
  _StoreCategorizedState createState() => _StoreCategorizedState();
}

class _StoreCategorizedState extends State<StoreCategorized> {
  StoreBloc _storetBloc = GetIt.instance.get<StoreBloc>();
  List<StoreCategorizedBloc> _blocs = new List<StoreCategorizedBloc>();
  List<StoreCategory> storeCats = new List<StoreCategory>();
  Size size;
  @override
  void initState() {
    categoryApi.getList().then((cats) {
      storeCats.clear();
      if (this.mounted) {
        setState(() {
          storeCats.addAll(cats);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // return FutureBuilder<List<StoreCategory>>(
    //     future: categoryApi.getList(),
    //     builder: (context, snapshotStoreCategories) {
    //       if (!snapshotStoreCategories.hasData) {
    //         return Container();
    //       }
    //       return Container(
    //         child: ListView(
    //           children: <Widget>[
    //             Container(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: _buildSections(snapshotStoreCategories.data),
    //               ),
    //             )
    //           ],
    //         ),
    //       );
    //     });
    if (storeCats.length == 0 || storeCats==null) {
      return Container();
    }
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildSections(storeCats),
              
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildSections(List<StoreCategory> cats) {
    _disposeBlocs();
    var result = cats.map((x) {
      var bloc = StoreCategorizedBloc(cityId: 1, catId: x.id);
      //For dispose all blocs add theme in list
      _blocs.add(bloc);
      return StreamBuilder<List<Store>>(
          stream: bloc.outMainList,
          builder: (BuildContext context, AsyncSnapshot<List<Store>> stores) {
            if (stores.data == null) {
              bloc.inAdverIndex.add(0);
              return Container();
            }
            return Section(
              title: x.title,
              onFetchData: () => bloc.inAdverIndex.add(stores.data.length),
              horizontalList: _buildStoreList(stores.data),
            );
          });
    }).toList();
    return result;
  }

  List<Widget> _buildStoreList(List<Store> items) {
    var results = items.map((item) {
      return GestureDetector(
        child: _buildStoreView(item),
        onTap: () {
          Navigator.of(context).pushNamed(
            '/storeDetails',
            arguments: item,
          );
        },
      );
    }).toList();
    return results;
  }

  Widget _buildStoreView(Store store) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: 190,
          height: 220,
          child: Card(
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              // elevation: 8.0,
              child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.network(
                    store.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '${store.title.substring(0, min(store.title.length, 50))}',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          // fontFamily: Preferences.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            store.address
                                .substring(0, min(50, store.address.length)),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context).textTheme.subtitle1),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposeBlocs();
    super.dispose();
  }

  void _disposeBlocs() {
       for (var i = 0; i < _blocs.length - 1; i++) {
      _blocs[i].dispose();
    }
  }
}
