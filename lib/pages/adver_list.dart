import 'dart:async';

import 'package:flutter/material.dart';
import '../blocs/adver_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../models/adver.dart';
import '../pages/filters.dart';
import '../tools/connection_status_singleton.dart';
import '../widgets/adver_card_widget.dart';

class AdverList extends StatefulWidget {
  @override
  _AdverListState createState() => _AdverListState();
}

class _AdverListState extends State<AdverList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final AdverBloc adverBloc = BlocProvider.of<AdverBloc>(context);
    List<Adver> advers = new List<Adver>();
// adverBloc.outConnectionController.listen((data)=>{
//    // adverBloc.inAdverIndex.add(advers.length+1)
// });
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text('آگهی ها'),
      //   actions: <Widget>[
      //     // Icon that gives direct access to the favorites
      //     // Also displays "real-time", the number of favorites
      //     FavoriteButton(child: const Icon(Icons.favorite)),
      //     // Icon to open the filters
      //     IconButton(
      //       icon: const Icon(Icons.more_horiz),
      //       onPressed: () {
      //         _scaffoldKey.currentState.openEndDrawer();
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              // Display an infinite GridView with the list of all movies in the catalog,
              // that meet the filters
              child: Stack(
            children: <Widget>[
              Container(
                child: StreamBuilder<List<Adver>>(
                    stream: adverBloc.outAdversList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Adver>> snapshot) {
                          advers=snapshot.data;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return _buildAdverCard(
                              context, adverBloc, index, snapshot.data);
                        },
                        itemCount:
                            (snapshot.data == null ? 0 : snapshot.data.length) +
                                20,
                      );
                    }),
              ),
              Container(
                child: StreamBuilder<bool>(
                    stream: adverBloc.outConnectionController,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return Visibility(
                          child: Container(
                              color: Colors.green,
                              height: 80.0,
                              child: new SizedBox.expand(
                                child: new RaisedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[                                     
                                      Text(
                                    "اتصال به اینترنت را بررسی کنید",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                   Icon(
                                        Icons.refresh,
                                        color: Colors.redAccent,
                                      ),
                                    ],
                                  ),
                                  
                                  elevation: 10.0,
                                  onPressed: () {
                                   // print(advers.length);
                                    adverBloc.inAdverIndex.add((advers != null) ? advers.length+adverBloc.itemsPerPage : 1);
                                  },
                                ),
                              )),
                          visible: !snapshot.data ?? false);
                    }),
              )
            ],
          )),
        ],
      ),
      endDrawer: FiltersPage(),
    );
  }

  Widget _buildAdverCard(
    BuildContext context,
    AdverBloc adverBloc,
    int index,
    List<Adver> advers,
  ) {
    // Notify the MovieCatalogBloc that we are rendering the MovieCard[index]
   adverBloc.inAdverIndex.add(index);

    // Get the MovieCard data
    final Adver movieCard =
        (advers != null && advers.length > index) ? advers[index] : null;

    if (movieCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return AdverWidget(
        key: Key('movie_${movieCard.id}'),
        adver: movieCard,
        onPressed: () {
          // Navigator
          //     .of(context)
          //     .push(MaterialPageRoute(builder: (BuildContext context) {
          //   return DetailsPage(
          //     data: movieCard,
          //   );
          // }));
        });
  }
}
