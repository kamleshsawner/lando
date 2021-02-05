import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lando/model/friend_request.dart';
import 'package:lando/model/friends.dart';
import 'package:lando/model/question.dart';
import 'package:lando/model/venue_users.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/package_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class QuestionsView extends StatefulWidget {
  @override
  _QuestionsViewState createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();

  SwiperController _controller = SwiperController();
  int _i = 0;
  var list = Question.getquestionlist();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: MyColors.COLOR_STATUS_BAR,
      ),
      backgroundColor: MyColors.COLOR_PRIMARY,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyColors.COLOR_PRIMARY_DARK, MyColors.COLOR_PRIMARY_LIGHT],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: Stack(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 25),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Text('')),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60,top: 60),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 500,
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 50),
                      child: Swiper(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 60,
                        layout: SwiperLayout.STACK,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(list[index].question,
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 10,
                                    style: TextStyle(
                                        fontSize: 22,
                                        height: 1.5,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      border: InputBorder.none,

                                    ),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.fromLTRB(30,20,30,20),
                                    child: MyGradientButton(
                                      child: Text('Submit',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                                      gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                                      height: 45,
                                      onPressed: (){
                                        if(list.length == 1){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PackageView() ));
                                        }else{
                                          list.removeAt(index);
                                          setState(() {

                                          });
                                        }
                                      },
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
