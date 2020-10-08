import 'package:flutter/material.dart';
import '../tools/preferences.dart';


class PhotoCircleScroller extends StatelessWidget {
  PhotoCircleScroller(this.urlsAndTitles);
  final Map<String,String> urlsAndTitles;
  

  Widget _buildActor(BuildContext ctx, int index) {
    var actor = urlsAndTitles[index];

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(          
            radius: 50.0,
            child: Image.network(urlsAndTitles.keys.elementAt(index)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(urlsAndTitles.values.elementAt(index)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'محصولات مشابه',
            style: textTheme.subhead.copyWith(fontSize: 18.0,fontFamily: Preferences.fontName,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(150.0),
          child: ListView.builder(
            itemCount: urlsAndTitles.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildActor,
          ),
        ),
      ],
    );
  }
}
