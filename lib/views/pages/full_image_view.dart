import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lando/model/response_model/response_myprofile.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/utility.dart';

class FullImageView extends StatefulWidget {

  List<Gallery> gallery_list;
  int img_index;

  FullImageView({this.gallery_list, this.img_index});

  @override
  _FullImageViewState createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  var _scaffold_key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 4.5;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
      key: _scaffold_key,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 55,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.cancel, size: 25),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Lando Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ))),
                  SizedBox(width: 50,)
                  // Text('1/10',style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 18),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 60, 10, 10),
              child:  Swiper(
                // pagination: new SwiperPagination(),
                itemCount: widget.gallery_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          image: NetworkImage(Utility.getCompletePath(widget.gallery_list[index].image)),
                          placeholder: AssetImage(MyAssets.ASSET_IMAGE_LOGO),
                        )
                    ),);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
