import 'package:flutter/material.dart';
import 'package:lando/util/mycolors.dart';

class CenterCircleIndicator extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Container(
                height: 80,width: 80,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.COLOR_PRIMARY_DARK),))));
  }

}
