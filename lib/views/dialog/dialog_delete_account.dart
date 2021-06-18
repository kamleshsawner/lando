import 'package:flutter/material.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';

class DialogDeleteAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: 170.0,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Text(
                        "Are you sure, you want to delete account?",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    )),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: RaisedButton(
                                onPressed: (){
                                  Navigator.pop(context,MyConstant.LOGOUT_YES);
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                splashColor: Colors.black.withAlpha(40),
                                child: Text(
                                  'Delete',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.COLOR_PRIMARY_DARK,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                            child:  ButtonTheme(
                                height: 35.0,
                                minWidth: 110.0,
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.COLOR_PRIMARY_DARK,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                ))
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
