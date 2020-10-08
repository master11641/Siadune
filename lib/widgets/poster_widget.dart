import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  PosterWidget(
    this.posterUrl, {
    this.height = 100.0,
  });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return Material(
      borderRadius: BorderRadius.circular(4.0),
      elevation: 2.0,
      child: Image.network(
        posterUrl,
        fit: BoxFit.fill,
        width: width,
        height: height,
      ),
    );
  }
}
