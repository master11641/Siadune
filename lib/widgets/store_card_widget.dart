import 'package:flutter/material.dart';
import '../models/store.dart';

class StoreCardWidget extends StatefulWidget {
  final Store store;
  final VoidCallback onPressed;
  StoreCardWidget({Key key, this.store, this.onPressed}) : super(key: key);
  _StoreCardWidgetState createState() => _StoreCardWidgetState();
}

class _StoreCardWidgetState extends State<StoreCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.key,
      child: Container(
          child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Image.network(widget.store.imageUrl),
                height: 100,
              ),
              Text(widget.store.title)
            ],
          ),
          elevation: 10.0,
        ),
        onTap: widget.onPressed,
      )),
    );
  }
}
