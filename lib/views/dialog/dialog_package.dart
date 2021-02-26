import 'package:flutter/material.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';

class DialogPackageSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: 150.0,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(icon: Icon(Icons.cancel_outlined,size: 35,color: MyColors.COLOR_PRIMARY,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0),
                      child: Text(
                        "Please Select Your Destination.",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
