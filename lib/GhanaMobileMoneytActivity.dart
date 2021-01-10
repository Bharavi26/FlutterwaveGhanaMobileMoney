
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:http/http.dart';
import 'package:flutterwave_ghanamobilemoney/helper/Constant.dart';
import 'package:flutterwave_ghanamobilemoney/helper/overlay_loader.dart';
import 'dart:async';

import 'GhanaPaymentWebview.dart';

class GhanaMobileMoneyActivity extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new GhanaMobileMoneyState();
  }

}
class GhanaMobileMoneyState extends State<GhanaMobileMoneyActivity>{
  Timer clocktimer;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool eventloading = false;
  String transactionid = "";

  var _networks = ['MTN', 'Tigo', 'Vodafone'];
  String _selectedNetwork;
  TextEditingController edtphone = TextEditingController();
  TextEditingController edtvoucher = TextEditingController();

  TextEditingController edtamount = TextEditingController();
  TextEditingController edtname = TextEditingController();
  TextEditingController edtemail = TextEditingController();

  bool isloading = false;
  String refno = "";
  int matchsecond = 5;
  bool startverify = false;
  int sendamt;




  @override
  void initState() {
    super.initState();
    _scaffoldKey =  GlobalKey<ScaffoldState>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
        appBar: AppBar(
          title: Text('FlutterWave GhanaMobileMoney'),
        ),
        backgroundColor: Colors.grey,
        body: Container(
          child: Stack(
            children: [
              Container(child: Center(
                child: Card(//margin: EdgeInsets.all(10),color: Colors.firstgradientcolor.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.only(left:12,right: 12,top: 10),
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(alignment: Alignment.centerRight,child: GestureDetector(onTap: (){exit(0);},child: Icon(Icons.close,color: Colors.grey,),)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Row(
                              children: [
                                Text("${Constant.CurrencySymbol}",style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),),
                                Text(edtamount.text,style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                                //Text(" $amount",style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                              ],
                            ),
                          ),
                          if(isVodaFoneSelected())Divider(),
                          SetTopWidget(),
                          SizedBox(height: 10),

                          TextFormField(
                            controller: edtname,
                            keyboardType: TextInputType.name,
                            validator: (val) => val.trim().isEmpty ? 'Enter Name' : null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),

                                  fillColor: Colors.grey[50],
                                  filled: true,
                                  errorStyle: TextStyle(fontSize: 12),
                                  errorMaxLines: 3,
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue, width: 1.5),
                                      borderRadius: radius),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 1),
                                      borderRadius: radius),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: .5),
                                      borderRadius: radius),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: 1),
                                      borderRadius: radius),
                                  hintText: 'Enter Name')
                          ),

                          TextFormField(
                            controller: edtemail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) => Constant.validateEmail(val),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),

                                  fillColor: Colors.grey[50],
                                  filled: true,
                                  errorStyle: TextStyle(fontSize: 12),
                                  errorMaxLines: 3,
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue, width: 1.5),
                                      borderRadius: radius),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 1),
                                      borderRadius: radius),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: .5),
                                      borderRadius: radius),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: 1),
                                      borderRadius: radius),
                                  hintText: 'Enter Email')
                          ),


                            TextField(
                                controller: edtphone,
                                textInputAction: isVodaFoneSelected()
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),

                                    fillColor: Colors.grey[50],
                                    filled: true,
                                    errorStyle: TextStyle(fontSize: 12),
                                    errorMaxLines: 3,
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.blue, width: 1.5),
                                        borderRadius: radius),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 1),
                                        borderRadius: radius),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[400].withOpacity(.7), width: .5),
                                        borderRadius: radius),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[400].withOpacity(.7), width: 1),
                                        borderRadius: radius),
                                    hintText: '233xxxxxxx')
                            ),

                          TextFormField(
                            controller: edtamount,
                            keyboardType: TextInputType.number,
                            validator: (val) => val.trim().isEmpty || double.parse(val.trim()) <= 0 ? "Enter Amount" : null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),

                                  fillColor: Colors.grey[50],
                                  filled: true,
                                  errorStyle: TextStyle(fontSize: 12),
                                  errorMaxLines: 3,
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.blue, width: 1.5),
                                      borderRadius: radius),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 1),
                                      borderRadius: radius),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: .5),
                                      borderRadius: radius),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[400].withOpacity(.7), width: 1),
                                      borderRadius: radius),
                                  hintText: 'Enter Amount')
                          ),
                          DropdownButtonHideUnderline(
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey[50],
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400].withOpacity(.7), width: .5),
                                    borderRadius: BorderRadius.all(Radius.circular(1.5))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400].withOpacity(.7), width: 1),
                                    borderRadius: BorderRadius.all(Radius.circular(1.5))),
                                hintText: 'Select network',
                              ),
                              isEmpty: _selectedNetwork == null,
                              child: new DropdownButton<String>(
                                value: _selectedNetwork,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() => _selectedNetwork = newValue);
                                },
                                items: _networks.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          if(isVodaFoneSelected())
                            TextField(
                              controller: edtvoucher,
                              textInputAction: TextInputAction.done,

                              decoration: InputDecoration(
                                hintText: 'VOUCHER/OTP',
                                labelText: 'VOUCHER/OTP',
                                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),

                                fillColor: Colors.grey[50],
                                filled: true,
                                errorStyle: TextStyle(fontSize: 12),
                                errorMaxLines: 3,
                                isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.blue, width: 1.5),
                                    borderRadius: radius),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    borderRadius: radius),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400].withOpacity(.7), width: .5),
                                    borderRadius: radius),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400].withOpacity(.7), width: 1),
                                    borderRadius: radius),
                              ),
                            ),

                          if(eventloading)
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new CircularProgressIndicator(),
                            )),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 20, bottom: 15),
                            child: FlatButton(
                              onPressed: () async {
                                if(!eventloading){
                                  bool checkinternet = await Constant.CheckInternet();
                                  if(_selectedNetwork == null){
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Select Network")));
                                    DismissSnackbar();
                                  }else if(Constant.validateMobile(edtphone.text.trim()) != null){
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(Constant.enter_valid_mobile)));
                                    DismissSnackbar();
                                  }else if(isVodaFoneSelected() && edtvoucher.text.trim().isEmpty){
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Enter Voucher")));
                                  DismissSnackbar();
                                }else if (!checkinternet) {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(Constant.lblchecknetwork)));
                                    DismissSnackbar();
                                  } else {


                                      transactionid = "${new DateTime.now().millisecond}";
                                      String ipAddress = await GetIp.ipAddress;

                                      Map data = {
                                    "tx_ref": transactionid,
                                    "amount":edtamount.text,
                                    "currency":Constant.CurrencyCode,
                                    //"voucher":"143256743",
                                    "network": _selectedNetwork,
                                    "email": edtemail.text,
                                    "phone_number": edtphone.text,
                                    "fullname": edtname.text,
                                    "client_ip":ipAddress,
                                    //"device_fingerprint":"62wd23423rq324323qew1",
                                    "redirect_url" : Constant.Localhosturl,
                                  };

                                  if(isVodaFoneSelected())
                                    data['voucher'] = edtvoucher.text;



                                      GhanaPayment(data);

                                  }}
                              },
                              color: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      child: Text(
                                         "Submit Voucher/OTP",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_right, color: Colors.white)
                                ],
                              ),
                            ),
                          ),

                          /*FlatButton(child: Text("test"),onPressed: (){
                            MPesaPayment();
                        },),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),),
              if(isloading)
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OverlayLoaderWidget(),
                      SizedBox(height: 20),
                      Text(
                        "Please, do not close this page.",
                        style: TextStyle(
                            color: Colors.redAccent,fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              if(startverify)
                Positioned.fill(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        matchsecond.toString(),
                        style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                            color: Colors.blue,fontWeight: FontWeight.bold
                        )),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        )
    );
  }


  Widget SetTopWidget() {
    if (isVodaFoneSelected()) {
      // This instruction is for Vodafone. Apparently, other networks don't need
      // instructions
      var textStyle = TextStyle(color: Colors.grey[900], fontWeight: FontWeight.normal);
      var boldStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 25),
        child: RichText(
          text: TextSpan(text: '', style: textStyle, children: <TextSpan>[
            TextSpan(
              text:
              'Please follow the instruction below to get your voucher code',
              style: boldStyle,
            ),
            TextSpan(text: '\n\n\n1. Dial '),
            TextSpan(text: '*110#', style: boldStyle),
            TextSpan(text: ' to generate your transaction voucher.'),
            TextSpan(text: '\n\n2. Select '),
            TextSpan(text: 'OPTION 6', style: boldStyle),
            TextSpan(text: ' to generate the voucher.'),
            TextSpan(text: '\n\n\3. Enter your PIN in next prompt.'),
            //TextSpan(text: '\n\n\4. Input the voucher generated in the voucher field below.'),
          ]),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  bool isVodaFoneSelected() => _networks.indexOf(_selectedNetwork) == 2;

  var radius = BorderRadius.all(Radius.circular(1.5));



  DismissSnackbar(){
    Timer(Duration(seconds: 1), () {
      _scaffoldKey.currentState.removeCurrentSnackBar();
    });
  }


  GhanaPayment(Map data) async {

    print("mpesa---");
    setState(() {
      eventloading = true;
    });

    String url;
    if(Constant.isFlutterwaveTest){
      url = Constant.ghanatesturl;
    }else{
      url = Constant.ghanaliveurl;
    }
    //transactionid = "${Constant.session.getData(UserSessionManager.KEY_ID)}_${new DateTime.now().millisecond}";

    print("mpesa--$transactionid--$url");

     Map data = {
      "tx_ref": transactionid,
      "amount":"5",
      "currency":"GHS",
      //"voucher":"143256743",
      "network":"MTN",
      "email":"user@gmail.com",
      "phone_number":"054709929220",
      "fullname":"John Madakin",
      "client_ip":"154.123.220.1",
      "device_fingerprint":"62wd23423rq324323qew1",
     "redirect_url" : Constant.Localhosturl,
    };


    //var body = JsonEncoder().convert(data);
    var body = utf8.encode(json.encode(data));

    Response response = await post(
      url,
      body: body,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer " + Constant.FlutterwaveSecKey
      },
    );


    setState(() {
      eventloading = false;

    });


    print("ghanapay-**--${response.statusCode}");
    print("ghanapay---${response.body.toString()}");
    final res = json.decode(response.body);
    if (response.statusCode == 200) {
      print("ghanapay---${response.body.toString()}");

      String status = res['status'];
      if(status.trim().toLowerCase() == "success" || status.trim().toLowerCase() == "successful"){
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(res['message'] ?? "Verifying Transaction")));
        String redirectionurl = res['meta']['authorization']['redirect'];
        print("===redirectionurl---$redirectionurl");

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GhanaPaymentWebview(redirectionurl,this.callback,transactionid)));


      }else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(res['message'] ?? "Transaction Failed")));
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(res['message'] ?? "Transaction Failed")));
    }

  }



  Future<void> callback() async {
    print("=====backwebview--$transactionid");

    //verifying transaction


          eventloading = true;


        Map vdata = {
          'txref': "$transactionid",
          'SECKEY':Constant.FlutterwaveSecKey
        };
        //var vbody = json.encode(vdata);
        var vbody = utf8.encode(json.encode(vdata));

        Response vresponse = await post(
          Constant.FlutterwaveVerifyUrl,
          body: vbody,
          headers: {
            "content-type": "application/json"
            //"Authorization": "Bearer " + Constant.FlutterwaveSecKey
          },
        );

        setState(() {
          eventloading = false;
          //event.isprocess = false;
        });

        final vres = json.decode(vresponse.body);



        if (vresponse.statusCode == 200) {
          print("mpesa--verify-${vresponse.body.toString()}");

          String vstatus = vres['status'];
          if(vstatus.trim().toLowerCase() == "success" || vstatus.trim().toLowerCase() == "successful"){
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(vres['message'] ?? "Transaction success")));
            //SetTransactionData(event,txref,"Ghana");
          }else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(vres['message'] ?? "Transaction Failed")));
          }

        }else{
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(vres['message'] ?? "Transaction Failed")));
        }

    edtname.clear();
    edtamount.clear();
    edtemail.clear();
    edtphone.clear();
    transactionid = '';
  }

}
