import 'package:flutter/material.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/store_bloc.dart';
import '../models/store.dart';
import '../pages/filters.dart';
import '../pages/store_details_page.dart';
import '../widgets/store_card_widget.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final StoreBloc storeBloc = BlocProvider.of<StoreBloc>(context);
    List<Store> stores = new List<Store>();
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              // Display an infinite GridView with the list of all movies in the catalog,
              // that meet the filters
              child: Stack(
            children: <Widget>[
              Container(
                child: StreamBuilder<List<Store>>(
                    stream: storeBloc.outMainList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Store>> snapshot) {
                      stores = snapshot.data;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data is! List<Store>) {
                            return Container();
                          }
                          return _buildAdverCard(
                              context, storeBloc, index, snapshot.data);
                        },
                        itemCount:
                            (storeBloc.doesStoreFetchEnded() == false ? snapshot.data.length : snapshot.data.length+20) ,
                      );
                    }),
              ),
              Container(
                child: StreamBuilder<bool>(
                    stream: storeBloc.outConnectionController,
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
                                    // storeBloc.inAdverIndex.add((stores != null)
                                    //     ? stores.length + storeBloc.itemsPerPage
                                    //     : 1);
                                    storeBloc.continueFetch();
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
    StoreBloc storeBloc,
    int index,
    List<Store> stores,
  ) {
    // Notify the MovieCatalogBloc that we are rendering the MovieCard[index]
    storeBloc.inAdverIndex.add(index);

    // Get the MovieCard data
    final Store movieCard =
        (stores != null && stores.length > index) ? stores[index] : null;

    if (movieCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return StoreCardWidget(
      key: Key('store_${movieCard.id}'),
      store: movieCard,
      onPressed: () {        
        Navigator.of(context).pushNamed(
          '/storeDetails',
          arguments: movieCard,
        );
      },
    );
  }
}
