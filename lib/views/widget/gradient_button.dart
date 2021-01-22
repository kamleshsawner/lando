import 'package:flutter/material.dart';

class MyGradientButton extends StatelessWidget {

  final Widget child;
  final double width;
  final double height;
  final Function onPressed;
  final Gradient gradient;

  const MyGradientButton({Key key,@required this.child,this.width,this.height,this.gradient,this.onPressed}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0.0,1.5),blurRadius: 1.5)]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(child: child,),
        ),
      ),
    );
  }
}
