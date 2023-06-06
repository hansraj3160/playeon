// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:playeon/auth/payfast.dart';
import 'package:playeon/auth/trail.dart';
import 'package:playeon/auth/user_model.dart';
import 'package:playeon/auth/vochercode.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'api_controller.dart';

class paymentScreen extends StatefulWidget {
  UserModel? userData;
  paymentScreen({super.key, this.userData});

  @override
  State<paymentScreen> createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen> {
   bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
  createTrial() async {
    setLoading(true);
   var response = await ApiController().trailUserCreate(widget.userData!);
    print(response);

    if (response == 200) {
      setLoading(false);
      Navigator.push(context,
          SwipeLeftAnimationRoute(milliseconds: 200, widget: TrailScreen()));
    } else if (response == 500){
      print("User name already taken");
    }
    else {
       setLoading(false);
      Fluttertoast.showToast(msg: response, toastLength: Toast.LENGTH_SHORT);
    }
  }

//  signupUser() async {
//     var getToken = await ApiController().gettokenCreate();
//     print(getToken);
//     if (getToken['status']) {
//       String accestoken = getToken['data']['ACCESS_TOKEN'];
//       String date = getToken['data']['GENERATED_DATE_TIME'];
//       print(date);
//       var response =
//           await ApiController().userCreate(widget.userData!, accestoken, date);

//       if (response == "200") {
//         Navigator.push(context,
//             SwipeLeftAnimationRoute(milliseconds: 200, widget: PayFast()));
//       } else {
//         Fluttertoast.showToast(msg: response, toastLength: Toast.LENGTH_SHORT);
//       }
//     }
//   }
  //! voucher user create

  userCreatetoVoucher() async {
     setLoading(true);
    var response = await ApiController().voucherUserCreate(widget.userData!);
    print(response);

    if (response == "200") {
       setLoading(false);
      Navigator.push(context,
      
          SwipeLeftAnimationRoute(milliseconds: 200, widget: VoucherCode()));
    } else {
       setLoading(false);
      Fluttertoast.showToast(msg: response, toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return 
     Stack(
       children: [

         Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VariableText(
                  text: "Choose your monthly subscription Package",
                  fontcolor: textColor1,
                  fontsize: size.height * 0.024,
                  fontFamily: fontMedium,
                  weight: FontWeight.w500,
                  max_lines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Container(
                  width: size.width * 0.80,
                  height: size.height * 0.30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(children: [
                      VariableText(
                        text: "STEP 3 of 4",
                        fontcolor: textColor1,
                        fontsize: size.height * 0.024,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      VariableText(
                        text: "Set up your payment",
                        fontsize: size.height * 0.030,
                        fontFamily: fontBold,
                        weight: FontWeight.w500,
                        max_lines: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VariableText(
                        text:
                            "Your membership starts as soon as you set up payment.",
                        fontFamily: fontMedium,
                        fontsize: size.height * 0.024,
                        weight: FontWeight.w300,
                        max_lines: 3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      VariableText(
                        text: "No commitments.",
                        fontFamily: fontMedium,
                        fontsize: size.height * 0.024,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Free Three Days Subscription"),
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(300, 70),
                            primary: textColor1,
                            alignment: Alignment.centerLeft,
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                            side: BorderSide(
                              color: textColor1,
                            ),
                          ),
                          onPressed: () {
                            createTrial();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.shopping_cart),
                          label: Text("Voucher Code"),
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(300, 70),
                            primary: textColor1,
                            alignment: Alignment.centerLeft,
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                            side: BorderSide(
                              color: textColor1,
                            ),
                          ),
                          onPressed: () {
                            userCreatetoVoucher();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ),
    if(isLoading )ProcessLoadingLight()
    

    
       ],
     );
  }
}
