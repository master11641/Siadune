import 'package:flutter/material.dart';
import 'package:siadune/app_setting_data/colors.dart';
import '../models/store.dart';
import '../tools/preferences.dart';
import '../widgets/arc_banner_image.dart';
import '../widgets/poster_widget.dart';

class StoreDetailsHeader extends StatelessWidget {
  StoreDetailsHeader(this.store);
  final Store store;

  // List<Widget> _buildCategoryChips(TextTheme textTheme) {
  //   return store.map((category) {
  //     return Padding(
  //       padding: const EdgeInsets.only(right: 8.0),
  //       child: Chip(
  //         label: Text(category),
  //         labelStyle: textTheme.caption,
  //         backgroundColor: Colors.black12,
  //       ),
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var storeInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          store.title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: CustomColor.primaryColor),
        ),
        SizedBox(height: 8.0),
        // RatingInformation(movie),
        Text(
          store.address,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontFamily: Preferences.fontName,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
              color: Colors.black54),
        ),
        SizedBox(height: 12.0),
        //Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(store.imageUrl),
        ),
        Positioned(
          bottom: 30.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PosterWidget(
                store.logoImageUrl,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: storeInformation),
            ],
          ),
        ),
      ],
    );
  }
}
