import 'package:flutter/material.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/views/pages/venue_user_view.dart';

class Venue {

  final int id;
  final String name;
  final String image;

  Venue({this.id,this.name,this.image});

  static List<Venue> getVenuelist(){
    var list = List<Venue>();
    list.add(Venue(id: 1,name: 'Ayia Napa',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    list.add(Venue(id: 2,name: 'libiza',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    list.add(Venue(id: 3,name: 'Kavos',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    list.add(Venue(id: 4,name: 'Maglauf',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    list.add(Venue(id: 5,name: 'Malia',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    list.add(Venue(id: 6,name: 'Marbella',image: MyAssets.ASSET_IMAGE_DUMMY_HOME));
    return list;
  }
}


class VenueAdapterView extends StatelessWidget{

  final Venue selected_venue;
  const VenueAdapterView({Key key, this.selected_venue}) : super(key: key);

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
            Container(child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: NetworkImage(''),
                    placeholder: AssetImage(selected_venue.image),
                    height: 180,fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width/2.2,
                  )
              ),),
            Container(
              child: Flexible(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(selected_venue.name, style: TextStyle(fontSize: 14,color: Colors.black)),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}