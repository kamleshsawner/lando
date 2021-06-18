import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:lando/util/my_routes.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/get_started_view.dart';
import 'package:lando/views/pages/home_view.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  dynamic user_id = await FlutterSession().get(MyConstant.SESSION_ID);
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lando',
          onGenerateRoute: MyRoutes.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          // home: GetStartedView()
          home: user_id == null || user_id == '' ?  GetStartedView()  :HomeView()
      )
  );
}


