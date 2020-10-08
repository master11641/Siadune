import 'package:flutter/material.dart';
import '../models/adver.dart';
import '../tools/preferences.dart';

class AdverWidget extends StatefulWidget {
  final Adver adver;
  final VoidCallback onPressed; 
  final bool noHero;
  const AdverWidget({Key key, this.adver, this.onPressed, this.noHero: true}) : super(key: key);

  @override
  _AdverWidgetState createState() => _AdverWidgetState();
}

class _AdverWidgetState extends State<AdverWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      ClipRect(
        clipper: _SquareClipper(),
        child: widget.noHero
               ? Image.network(widget.adver.imagees.first.url,
              fit: BoxFit.cover)
               : Hero(
          child: Image.network(widget.adver.imagees.first.url,
              fit: BoxFit.cover),
          tag: 'movie_${widget.adver.id}',
        ),
      ),
      Container(
        decoration: _buildGradientBackground(),
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: _buildTextualInfo(widget.adver),
      ),
    ];

     return InkWell(
      onTap: widget.onPressed,
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: children,
        ),
      ),
    );
    // return Container(
    //   child: Card(
    //     child: new Container(
    //     constraints: new BoxConstraints.expand(
    //       height: 200.0,
    //     ),
    //     padding: new EdgeInsets.only(left: 0.0, bottom: 0.0, right: 0.0),
    //     decoration: new BoxDecoration(
    //       image: new DecorationImage(
    //         image: new NetworkImage(widget.adver.imagees.first.url),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     child: Container(
    //       decoration: _buildGradientBackground(),
    //       child: new Stack(
    //       children: <Widget>[
    //         new Positioned(
    //           right: 0.0,
    //           bottom: 0.0,
    //           child: _buildTextualInfo(widget.adver)
    //         ),
    //         // new Positioned(
    //         //   right: 0.0,
    //         //   bottom: 0.0,
    //         //   child: new Icon(Icons.star),
    //         // ),
    //       ],
    //     ),
    //     )
    // ),
    //     ),
    // );
  }
  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topRight,
        stops: <double>[0.0, 0.7, 0.7],
        colors: <Color>[
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }
  Widget _buildTextualInfo(Adver adver) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          adver.title,
          textDirection: TextDirection.rtl,
           textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,            
            fontSize: 16.0,
            color: Colors.white,
            fontFamily: 'IRANSansMobile'
          ),
        ),   
      ],
    );
  }
}

class _SquareClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

