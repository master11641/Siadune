import 'package:flutter/material.dart';
import 'package:siadune/app_setting_data/colors.dart';

class Section extends StatefulWidget {
  final List<Widget> horizontalList;
  final String title;
  final VoidCallback onTapped;
  final VoidCallback onFetchData;
  //PostBloc _postBloc = GetIt.instance.get<PostBloc>();
  Section({this.title, this.horizontalList, this.onTapped, this.onFetchData});

  @override
  _SectionState createState() => _SectionState();
}

class _SectionState extends State<Section> {
  Size size;
  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.position.extentAfter);
      if (_scrollController.position.extentAfter <= 500) {
        // widget._postBloc.inAdverIndex.add(widget.horizontalList.length);
        if (widget.onFetchData != null) {
          widget.onFetchData();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle((this.widget.title != null) ? this.widget.title : ""),
          Container(
            padding: EdgeInsets.only(left: 50,right: 10),
            width: size.width/2,
              child: Divider(
            color: CustomColor.primaryColor,
          )),
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (this.widget.horizontalList != null)
                    ? this.widget.horizontalList
                    : []),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String _text;

  SectionTitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(this._text,
            style: Theme.of(context)
                .textTheme
                .headline6
                ),
      ),
    );
  }
}
