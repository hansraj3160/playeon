class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? username;
  String? phoneNumber;
  String? country;
  String? plan;
  String? paymentMethod;
  String? role;
  String? profilePicture;
  String? voucherExpiryDate;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.username,
      this.phoneNumber,
      this.country,
      this.plan,
      this.paymentMethod,
      this.role,
      this.profilePicture,
      this.voucherExpiryDate,
      this.isLoggedIn,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
    plan = json['plan'];
    paymentMethod = json['paymentMethod'];
    role = json['role'];
    profilePicture = json['profilePicture'];
    voucherExpiryDate = json['voucherExpiryDate'];
    isLoggedIn = json['isLoggedIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
