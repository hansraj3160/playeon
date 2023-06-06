import 'dart:convert';
import 'package:playeon/auth/user_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  final int _timeoutDuration = 15;
  //! login user

  Future<dynamic> loginUser(String userName, String password) async {
    var url = "https://apiv1.playeon.com/api/v1/auth";
    var data = {
      "user": {"username": userName, "password": password}
    };
    print(url);
    var response = await http
        .post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    )
        .timeout(Duration(seconds: _timeoutDuration), onTimeout: () {
      throw "Request time out";
    });
    print("Response ${response.statusCode}");

    if (response.statusCode == 200) {
      var datas = jsonDecode(utf8.decode(response.bodyBytes));
      var data = {"status": true, "msg": datas};
      return data;
    } else if (response.statusCode == 401) {
      // var statusData = jsonDecode(utf8.decode(response.bodyBytes));
      // print(statusData);
      var data = {"status": false, "msg": response.body};
      return data;
    }
  }

  //! user Create
  Future<dynamic> trailUserCreate(UserModel userDetails) async {
    var url = "https://apiv1.playeon.com/api/v1/signup/trial";
    var data = {
      "user": {
        "name": userDetails.name,
        "email": userDetails.email,
        "username": userDetails.username,
        "password": userDetails.password,
        "phoneNumber": userDetails.phone,
        "country": userDetails.country,
        "plan": "planOne",
        "paymentMethod": "card",
        "planPrice": 100,
        "trasntionId": "0dda010f-4d17-a322-3xb3-178d08def5b9",
        "BdoId": 18617
      }
    };
    print(json.encode(data));
    try {
      var response = await http
          .post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      )
          .timeout(Duration(seconds: _timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var datas = jsonDecode(utf8.decode(response.bodyBytes));

        return response.statusCode;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));

        return response.statusCode;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> userCreate(
      UserModel userDetails, String token, String date) async {
    var url = "https://apiv1.playeon.com/api/v1/signup/payfast";
    var userSignupdata = {
      "user": {
        "name": userDetails.name,
        "email": userDetails.email,
        "username": userDetails.username,
        "password": userDetails.password,
        "phoneNumber": userDetails.phone,
        "country": userDetails.country,
        "plan": "planOne",
        "paymentMethod": "card",
        "planPrice": 100,
        "voucher": "gEtN5tXKCy",
        "BdoId": 18617
      }
    };
    // print("url $url and ${json.encode(userSignupdata)}");
    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(userSignupdata));

      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> postTransaction(
      UserModel userDetails, String token, String date) async {
    var url =
        "https://ipg1.apps.net.pk/Ecommerce/api/Transaction/PostTransaction";
    var userSignupdata = {
      "user": {
        "MERCHANT_ID": "14392",
        "MERCHANT_NAME": "Playeon",
        "TOKEN": token,
        "PROCCODE": "00",
        "TXNAMT": "100",
        "CUSTOMER_MOBILE_NO": userDetails.phone,
        "CUSTOMER_EMAIL_ADDRESS": userDetails.email,
        "SIGNATURE": "playeonPayment",
        "VERSION": "v1",
        "TXNDESC": "planOne",
        "SUCCESS_URL": "https://www.playeon.com/signup/success",
        "FAILURE_URL": "https://www.playeon.com/signup/failure",
        "BASKET_ID": "101",
        "ORDER_DATE": date,
        "CHECKOUT_URL":
            "https://apiv1.playeon.com/api/v1/signup/payment/confirmation"
      }
    };

    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(userSignupdata))
          .timeout(Duration(seconds: _timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> gettokenCreate() async {
    var url =
        "https://ipg1.apps.net.pk/Ecommerce/api/Transaction/GetAccessToken";
    var userSignupdata = {
      "MERCHANT_ID": 14392,
      "SECURED_KEY": "sS7ulxd4pGwExxo5g9XMwc"
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(userSignupdata));
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> voucherUserCreate(UserModel userDetails) async {
    var url = "https://apiv1.playeon.com/api/v1/signup";
    var userSignupdata = {
      {
        "user": {
          "name": "John Doe",
          "email": "johndoe1@example.com",
          "username": "johndo1e",
          "password": "mypassword",
          "phoneNumber": "1234567890",
          "country": "US",
          "plan": "Basic",
          "paymentMethod": "voucher",
          "voucher": "NqSIcTwH6X",
          "BdoId": "123456"
        }
      }
    };
    print("url $url and ${json.encode(userSignupdata)}");
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(userSignupdata))
          .timeout(Duration(seconds: _timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> getMovies(
    String accessToken,
  ) async {
    var url = "https://apiv1.playeon.com/api/v1/movie";
    print(url + accessToken);
    // print("url $url and ${json.encode(userSignupdata)}");
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDU4ZDUwOWJlZjQzNzgwMTk4MTYzYWIiLCJpYXQiOjE2ODM1NDMzMDUsImV4cCI6MTcxNTA3OTMwNX0.7v-oCZ9tm4bMa9So71987T-Wc7qiPFoL1EcIjUh0pp4'
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<dynamic> getCategories(String accessToken, String? category) async {
    var url = "https://apiv1.playeon.com/api/v1/movie/list/$category";
    print(url + accessToken);
    // print("url $url and ${json.encode(userSignupdata)}");
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDU4ZDUwOWJlZjQzNzgwMTk4MTYzYWIiLCJpYXQiOjE2ODM1NDMzMDUsImV4cCI6MTcxNTA3OTMwNX0.7v-oCZ9tm4bMa9So71987T-Wc7qiPFoL1EcIjUh0pp4'
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

// import 'package:http/http.dart' as http;

  Future<dynamic> getSeries(
    String accessToken,
  ) async {
    var url = "https://apiv1.playeon.com/api/v1/series";
    print(url + accessToken);
    // print("url $url and ${json.encode(userSignupdata)}");
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDU4ZDUwOWJlZjQzNzgwMTk4MTYzYWIiLCJpYXQiOjE2ODM1NDMzMDUsImV4cCI6MTcxNTA3OTMwNX0.7v-oCZ9tm4bMa9So71987T-Wc7qiPFoL1EcIjUh0pp4'
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        var statusData = jsonDecode(utf8.decode(response.bodyBytes));
        return statusData['msg'].toString();
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}


// Future<void> fetchData() async {
//   final url = Uri.parse('https://apiv1.playeon.com/api/v1/movie');

//   final response = await http.get(
//     url,
//     headers: {
//       'Authorization': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDU4ZDUwOWJlZjQzNzgwMTk4MTYzYWIiLCJpYXQiOjE2ODM1NDMzMDUsImV4cCI6MTcxNTA3OTMwNX0.7v-oCZ9tm4bMa9So71987T-Wc7qiPFoL1EcIjUh0pp4",
//     },
//   );

//   if (response.statusCode == 200) {
//     // Handle successful response
//     print(response.body);
//   } else {
//     // Handle error response
//     print('Error: ${response.statusCode}');
//   }
// }
