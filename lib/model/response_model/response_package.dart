
import 'package:flutter/material.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class ResponsePackage{

  int status;
  String message;
  List<Package> pack_list;

  ResponsePackage({this.status,this.message,this.pack_list});

}

class Package{

  int id;
  String title;
  double amount;
  int destination;
  int duration;
  int instant_time;
  String upload_photo;
  String share_network;
  int like;
  int send_request;

  Package({this.id,this.title,this.amount,this.destination,this.duration,this.instant_time,this.upload_photo,this.share_network,
  this.like,this.send_request});

  factory Package.fromjson(Map<String,dynamic> json){
    return Package(
      id: json['id'],
      title: json['title'],
      amount : json['amount'].toDouble(),
      destination : json['groups'],
      duration : json['duration'],
      instant_time : json['instant_time'],
      upload_photo : json['upload_photos'],
      share_network : json['share_in_network'],
      like : json['like_count'],
      send_request : json['send_request'],
    );
  }

  String getAmount(double amonut){
    return amonut == 0 ? 'Free' : '£ $amonut';
  }

  String getDestination(int destination){
    return destination == 1 ? '* 1 Destination' : '* Multiple Destinations ';
  }

  String getTime(int time){
    return time == 24 ? '* 24 hours connect chat time' : '* Instant time chat';
  }

  String getupload(String type){
    return type == 'no' ? '' : '* Upload photos';
  }

  String getShare(String share){
    return share == 'no' ? '' : '* Share in Network';
  }

  String getLike(int like){
    return like == 0 ? '* Unlimited Likes' : '* Limited Likes';
  }

  String getSendRequest(int request){
    return request == 0 ? '* Unlimited Send Requests' : '* Limited Send Requests';
  }

}



class PackageAdapterView extends StatelessWidget{

  final Package selected_venue;
  final Function onPressed;

  const PackageAdapterView({Key key, this.selected_venue,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width/2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                selected_venue.title,style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 20,fontWeight: FontWeight.bold),
              )),
          Expanded(child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getDestination(selected_venue.destination),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getTime(selected_venue.instant_time),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getupload(selected_venue.upload_photo),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getShare(selected_venue.share_network),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getLike(selected_venue.like),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10,5,10,0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(selected_venue.getSendRequest(selected_venue.send_request),style: TextStyle(color: Colors.black,fontSize: 16),)),
              ),
            ],
          )),
          Container(
              margin: EdgeInsets.all(10),
              height: 40,
              child: MyGradientButton(
                child: Text(selected_venue.getAmount(selected_venue.amount),style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w400),),
                gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                height: 45,
                onPressed: onPressed,
              )
          ),
        ],
      ),
    );
  }


}