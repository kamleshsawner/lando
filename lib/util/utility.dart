import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lando/api/api_services.dart';

class Utility{

  static String getCompletePath(String url){
    return APIServices.BASE_PROFILE_IMAGE_URL+url;
  }

  static String getFormatedDate(DateTime dateTime) {
    if(dateTime == null){
      dateTime = new DateTime.now();
    }
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String getWeekDayName(int dayno){
    if(dayno == 1) return 'Monday ';
    if(dayno == 2) return 'Tuesday';
    if(dayno == 3) return 'Wednesday';
    if(dayno == 4) return 'Thursday';
    if(dayno == 5) return 'Friday';
    if(dayno == 6) return 'Saturday';
    if(dayno == 7) return 'Sunday';
  }

  static showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  static showToast(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<bool> checkInternetConnection() async{
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
      Utility.showToast('No internet. Please check your connection');
      return false;
    }else if(result == ConnectivityResult.mobile){
      return true;
    }else if(result == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }

}