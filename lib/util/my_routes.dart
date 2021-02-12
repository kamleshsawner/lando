import 'package:flutter/material.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/pages/signin_view.dart';


class MyRoutes{


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SigninView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) => SigninView());
    }
  }

}