import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lando/api/api_services.dart';
import 'package:lando/model/request_model/request_submitanswer.dart';
import 'package:lando/model/response_model/response_message.dart';
import 'package:lando/model/response_model/response_question.dart';
import 'package:lando/util/mycolors.dart';
import 'package:lando/util/myconstant.dart';
import 'package:lando/util/utility.dart';
import 'package:lando/views/pages/home_view.dart';
import 'package:lando/views/pages/package_view.dart';
import 'package:lando/views/widget/center_circle_indicator.dart';
import 'package:lando/views/widget/gradient_button.dart';

class QuestionsView extends StatefulWidget {
  @override
  _QuestionsViewState createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {

  var _scaffold_key = GlobalKey<ScaffoldState>();
  var is_loading = true;
  ResponseQuestions responseQuestions;
  var ans_controller = TextEditingController();

  SwiperController _controller = SwiperController();
  var list = List<Question>();
  int my_index = 0;

  @override
  void initState() {
    super.initState();
    Utility().checkInternetConnection().then((internet) => {
      if (internet){
        getData(),
      }
    });
  }
  // get data
  Future<Null> getData() async {
    await APIServices().getQuestions().then((qes_response) => {
      responseQuestions = qes_response,
      if(responseQuestions.status == 200){
        list = responseQuestions.ques_list
      },
      setState(() {
        is_loading = false;
      }),
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        _removeQuestion();
      },
      child: Scaffold(
        key: _scaffold_key,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: MyColors.COLOR_STATUS_BAR,
        ),
        backgroundColor: MyColors.COLOR_PRIMARY,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyColors.COLOR_PRIMARY_DARK, MyColors.COLOR_PRIMARY_LIGHT],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.7])),
          child: Stack(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,size: 25),
                      color: Colors.white,
                      onPressed: (){
                        _removeQuestion();
                      },
                    ),
                    Expanded(child: Text('')),
                  ],
                ),
              ),
              if (is_loading) CenterCircleIndicator() else Container(
                margin: EdgeInsets.only(bottom: 60,top: 60),
                child: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 500,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 50),
                        child: Swiper(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemWidth: MediaQuery.of(context).size.width - 2 * 60,
                          layout: SwiperLayout.STACK,
                          controller: _controller,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(list[index].question,
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                                  Expanded(
                                    child: TextFormField(
                                      maxLines: 10,
                                      controller: ans_controller,
                                      style: TextStyle(
                                          fontSize: 22,
                                          height: 1.5,
                                          color: Colors.black
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Answer',
                                        border: InputBorder.none,

                                      ),
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.fromLTRB(30,20,30,20),
                                      child: MyGradientButton(
                                        child: Text('Submit',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                                        gradient: LinearGradient(colors: [MyColors.COLOR_PRIMARY_LIGHT,MyColors.COLOR_PRIMARY_DARK,]),
                                        height: 45,
                                        onPressed: (){
                                          _submitAnswer(index,list[index].id);
                                        },
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAnswer(int index,int ques_id) async{
    var answer = ans_controller.text.toString();
    if(answer == ''){
      Utility.showToast('Please enter your answer');
    }else{
      setState(() {
        is_loading = true;
      });
      var user_id = await FlutterSession().get(MyConstant.SESSION_ID);
      RequestSubmitAnswer requestSubmitAnswer = RequestSubmitAnswer(user_id: user_id.toString(),answer: answer,ques_id:ques_id.toString() );
      ResponseMessage responsemessage = await APIServices().submitAnswer(requestSubmitAnswer);
      ans_controller.text =  '';
      showMessage(responsemessage.message);

      if(list.length == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageView() ));
      }else{
        list.removeAt(index);
        my_index = ++my_index;
        if(my_index == 3 || my_index > 3){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageView() ));
        }
        setState(() {
        });
      }
    }

  }

  void showMessage(String message) {
    setState(() {
      is_loading = false;
      Utility.showInSnackBar(message, _scaffold_key);
    });
  }

  void _removeQuestion() {
    if(my_index == 3 || my_index > 3){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageView() ));
    }else{
      Utility.showInSnackBar('Please Submit atleast 3 Answer.', _scaffold_key);
    }
  }


}
