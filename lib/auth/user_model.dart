import 'dart:convert';

class UserModel {
  int? id;

  String? name;

  String? username;
 
  String? email;
  String? phone;
  String? country;

  String? password;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.country,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      username = json['user_name'];
      password = json['password'];
    
    } catch (e) {
      print("PaymentModel.fromJson: $e");
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = username;
    data['password'] = password;
   
    return data;
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}
