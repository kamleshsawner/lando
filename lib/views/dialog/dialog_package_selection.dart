import 'package:flutter/material.dart';
import 'package:lando/model/response_model/response_destination.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/views/pages/check_allprofile_view.dart';

class DialogPackageSelection extends StatelessWidget {

  List<Destination> dest_list;

  DialogPackageSelection({this.dest_list});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 300,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Please Select Destination",
                          style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.cancel_outlined,color: MyColors.COLOR_PRIMARY,), onPressed: (){
                      Navigator.pop(context);
                    })
                  ],
                ),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dest_list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      PackageSelectAdapterView(selected_friend: dest_list[index]),
                )
              ],
            )),
      ),
    );
  }
}


class PackageSelectAdapterView extends StatelessWidget{

  final Destination selected_friend;
  const PackageSelectAdapterView({Key key, this.selected_friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CheckAllProfileView(id: selected_friend.id.toString(),name: selected_friend.title,)
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(selected_friend.title,style: TextStyle(color: Colors.black,fontSize: 18),),
        ),
      ),
    );
  }

}
