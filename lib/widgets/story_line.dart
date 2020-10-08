import 'package:flutter/material.dart';
import '../tools/preferences.dart';

class Storyline extends StatelessWidget {
  Storyline(this.storyline);
  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'توضیحات',
          style: TextStyle(fontFamily: Preferences.fontName,fontSize: 16.0,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          storyline,
          style: textTheme.body1.copyWith(
            color: Colors.black45,
            fontSize: 16.0,
            fontFamily: Preferences.fontName
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'more',
              style: textTheme.body1
                  .copyWith(fontSize: 16.0, color: theme.accentColor),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
