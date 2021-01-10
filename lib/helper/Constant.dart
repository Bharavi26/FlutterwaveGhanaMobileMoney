import 'package:connectivity/connectivity.dart';

class Constant {

  static String ghanatesturl = "https://ravesandboxapi.flutterwave.com/v3/charges?type=mobile_money_ghana";
  static String ghanaliveurl = "https://api.flutterwave.com/v3/charges?type=mobile_money_ghana";
  static String FlutterwaveVerifyUrl = "https://api.ravepay.co/flwv3-pug/getpaidx/api/v2/verify";

  static String Localhosturl = "http://127.0.0.1:8184";
  static bool isFlutterwaveTest = true;


  static String FlutterwaveCurrency = "KES";
  static String FlutterwaveCountry = "KE";

  static String FlutterwavePubKey = "FLWPUBK_TEST-456cfd00097c1bcf60e384f92619cef5-X";
  static String FlutterwaveEncKey = "FLWSECK_TEST549a8e139e7e";
  static String FlutterwaveSecKey = "FLWSECK_TEST-ea7fe8f3a11dbef50dad41dc50adc491-X";


  static String CurrencySymbol = 'GH₵';
  static String CurrencyCode = "GHS";

  static String lblchecknetwork = 'Check Internet Connection';
  static String enter_valid_email = "Enter Valid Email Address";
  static String enter_valid_mobile = "Enter Valid Mobile Number.";

  static String validateMobile(String value) {
    if (value.trim().isEmpty || value.trim().length < 10 || value.trim().length > 14)
      return 'Enter Valid Mobile Number';
    else
      return null;
  }

  static String validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.trim().isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static Future<bool> CheckInternet() async {
    bool check = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      //print("===check==true");
      // return true;
      check = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //print("===check=***=true");
      //return true;
      check = true;
    }
    //print("===check==false");
    //return false;
    return check;
  }

}