
class RequestSelectPackage{

   String user_id;
   String package_id;

  RequestSelectPackage({this.package_id,this.user_id});

  Map<String,dynamic> tojson() => {
    'userid':this.user_id,
    'packageid':this.package_id,
  };

}