import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../models/goods.dart';
import '../tools/preferences.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({Key key, this.goods}) : super(key: key);
final Goods goods;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
          child: SizedBox(
              height: 300.0,
              width: double.infinity,
              child: Carousel(
                images:                   
               createPhotoViews()
                ,
                dotSize: 4.0,
                autoplay: false,
                dotSpacing: 15.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.purple.withOpacity(0.5),
                borderRadius: false,
                moveIndicatorFromBottom: 180.0,
                noRadiusForIndicator: true,
                overlayShadow: true,
                overlayShadowColors: Colors.white,
                overlayShadowSize: 0.7,
              )),
              
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share,color: Colors.grey,),
              onPressed: ()=>{},
            ),
              IconButton(
              icon: Icon(Icons.favorite,color: Colors.grey,),
              onPressed: ()=>{},
            ),
          ],
        ),
        SizedBox(height: 8,),
         Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 20,left: 20),
                    child: Text(
                      '${goods.title}',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
          ],
        )
      ),
    );
  }

   List<dynamic> createPhotoViews(){
  return   goods.tgoodsImages.map((f)=>   PhotoView(
                    imageProvider: NetworkImage(
                        f.imageUrl),
                  )).toList();
   }
}
