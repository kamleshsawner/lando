import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
 // String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  // String clientId = 'Ab4vS4vmfQFgUuQMH49F9Uy3L1FdNHtfGrASCyjNijm_EkHWCFM96ex0la-YFbwavw41R3rTKU3k_Bbm';
  // String secret = 'EDjvPfYgTYqdYWR2BfOiBW4dz_jeeuadqH7Z98pZMDvY33PcViiooqYFWVPFSGbfKBfNOb3LnroSI1hv';

  // lando test production - kamleshsawner89
  // String clientId = 'AT4U2cTqYkG8gANq08PwUHXTzGY51l-roG2F48XR_g_O1zzhSKMqpzvMQC_lR3dvtDIJv85H6WT7qq3L';
  // String secret = 'EPoum06f6zKUkk1rfo33G17Iu2Z19IUQ2SftnRNOcvn58-B-9XK3QM8YXqsXo1vFljXxWBrBcWhJED-1';

  // lando sandbox - client user login
  String clientId = 'AVrIw8PD4VHSBUw9dbHWBjZ6WSivZvgn3GRdMHBbW0OIJehW0NNN1vgDrLTUvigK0tZ4GCLoGNz7v9Rv';
  String secret = 'EJo_ZtoSwwZHlP5aDSVA1S5x1EWXdNWCfiiqnYjbIL699ouWIhvdwRIklezFuaaY2cgFEy3kNB-cAX5f';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post('$domain/v1/oauth2/token?grant_type=client_credentials');
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post("$domain/v1/payments/payment",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}