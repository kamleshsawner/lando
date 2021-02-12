
class RequestReportUser{

   String userid;
   String action_reportto;

  RequestReportUser({this.userid,this.action_reportto});

  Map<String,dynamic> tojson() => {
    'report_to':this.action_reportto,
    'userid':this.userid,
  };

}