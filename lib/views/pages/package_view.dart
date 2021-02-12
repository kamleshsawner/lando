import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_selectpackage.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/model/response_model/response_package.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class PackageView extends StatefulWidget {
  @override
  _PackageViewState createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  var is_loading_select = false;
  ResponsePackage res_package;

  @override
  void initState() {
    super.initState();
    Utility().checkInternetConnection().then((internet) => {
      if (internet){
        getData(),
      }
    });
  }

  // get data
  Future<Null> getData() async {
    await APIServices().getPackage().then((res_pack) => {
      res_package = res_pack,
      setState(() {
        is_loading = false;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2.2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      key: _scaffold_key,
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
                    icon: Icon(Icons.arrow_back_ios,size: 30),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Center(child: Text('Package',style: TextStyle(color: Colors.white,fontSize: 20),))),
                  SizedBox(width: 40,),
                ],
              ),
            ),
            is_loading ? CenterCircleIndicator() : Container(
              margin: EdgeInsets.only(top: 55),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: GridView.count(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        children: List.generate(res_package.pack_list.length, (index) {
                          return Center(
                            child: PackageAdapterView(
                                selected_venue:
                                res_package.pack_list[index],
                              onPressed: (){
                                  submitData(res_package.pack_list[index]);
                              },
                            ),
                          );
                        })),
                  )
                ],
              ),
            ),
            is_loading_select ? CenterCircleIndicator() : Text('')
          ],
        ),
      ),
    );
  }

  Future<Null> submitData(Package package) async{
    is_loading_select = true;
    setState(() {
    });
    ResponseMessage responsemessage;
    await FlutterSession().get(MyConstant.SESSION_ID).then((userid) => {
      APIServices().selectPackage(RequestSelectPackage(user_id: userid.toString(),package_id: package.id.toString())).then((dest_value) => {
        responsemessage = dest_value,
        setState(() {
          is_loading_select = false;
        }),
        Utility.showToast(responsemessage.message),
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeView()
        )),
      })
    });
  }
}


