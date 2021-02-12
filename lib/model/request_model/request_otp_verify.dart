
class RequestOTPVerify{

  String userid;
  String otp;

  RequestOTPVerify({this.userid,this.otp});

  Map<String,dynamic> tojson() => {
    'userid':this.userid,
    'otp':this.otp,
  };

}