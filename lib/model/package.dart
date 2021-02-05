import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/pages/venue_user_view.dart';
import 'package:lando/views/widget/gradient_button.dart';

class Package {

  final int id;
  final String name;
  final String decription;
  final String price;

  Package({this.id,this.name,this.decription,this.price});

  static String des = '1 Destination\n24 hour connect\n15like/send request\nupload photo';

  static List<Package> getVenuelist(){
    var list = List<Package>();
    list.add(Package(id: 1,name: 'Standard',decription: des,price: '25'));
    list.add(Package(id: 2,name: '1 Month',decription: des,price: '25'));
    list.add(Package(id: 3,name: '3 Month',decription: des,price: '25'));
    list.add(Package(id: 4,name: '6 Month',decription: des,price: '25'));
    return list;
  }
}


class PackageAdapterView extends StatelessWidget{

  final Package selected_venue;
  const PackageAdapterView({Key key, this.selected_venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VenueUserView()));
      },
      child: Container(
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
              selected_venue.name,style: TextStyle(color: MyColors.COLOR_PRIMARY_DARK,fontSize: 20,fontWeight: FontWeight.bold),
            )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Text(selected_venue.decription,style: TextStyle(color: Colors.black,fontSize: 18),)),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: 40,
                child: MyGradientButton(
                  child: Text('£ ${selected_venue.price}',style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w400),),
                  gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                  height: 45,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView() ));
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

}