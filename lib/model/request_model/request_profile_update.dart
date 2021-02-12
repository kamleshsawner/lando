
import 'dart:io';

class RequestProfileUpdate{

   String user_id;
   String name;
   String email;
   String dob;
   String mobile;
   File image;

  RequestProfileUpdate({this.user_id,this.name,this.email,this.dob,this.mobile,this.image});


}