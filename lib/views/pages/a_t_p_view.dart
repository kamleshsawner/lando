import 'package:flutter/material.dart';
import 'package:lando/util/mycolors.dart';

class ATPView extends StatefulWidget {

  String title;
  String cotent;

  ATPView({this.title,this.cotent});

  @override
  _ATPViewState createState() => _ATPViewState();
}

class _ATPViewState extends State<ATPView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColors.COLOR_STATUS_BAR,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_DARK,MyColors.COLOR_PRIMARY_LIGHT],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 25),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                              widget.title,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ))),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10,60,10,10),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(widget.cotent,
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: Colors.white,fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
