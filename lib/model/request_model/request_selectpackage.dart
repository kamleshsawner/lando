
class RequestSelectPackage{

  String user_id;
  String package_id;
  String amount;
  String payer_id;
  String txn_id;

  RequestSelectPackage({this.package_id,this.user_id,this.amount,this.payer_id,this.txn_id});

  Map<String,dynamic> tojson() => {
    'userid':this.user_id,
    'packageid':this.package_id,
    'amount':this.amount,
    'payer_id':this.payer_id,
    'txn_id':this.txn_id,
  };

}