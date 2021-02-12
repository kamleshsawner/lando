import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lando/model/response_model/response_friend_req_list.dart';
import 'package:lando/util/myassets.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/chat_view.dart';

class BlockUserAdapterView extends StatelessWidget{

  final ReqUser selected_friend;
  final Function onPressedunblock;

  const BlockUserAdapterView({Key key, this.selected_friend,this.onPressedunblock}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage(
                      image: NetworkImage(Utility.getCompletePath(selected_friend.image)),
                      placeholder: AssetImage(MyAssets.ASSET_IMAGE_LIST_DUMMY_PROFILE),
                      height: 60,
                      fit: BoxFit.fill,
                      width:60,
                    )
                ),),
              SizedBox(width: 20,),
              Expanded(child: Text(
                '${selected_friend.name}',style: TextStyle(
                color: Colors.black,
                fontSize: 16,fontWeight: FontWeight.bold
              ),
              ),),
              GestureDetector(
                onTap: onPressedunblock,
                child: Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.fromLTRB(10,8,10,8),
                    child: Text('Unblock',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        ],
      ),
    );
  }

}