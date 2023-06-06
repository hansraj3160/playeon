class get_token {
  int? mERCHANTID;
  String? aCCESSTOKEN;
  String? nAME;
  String? gENERATEDDATETIME;

  get_token(
      {this.mERCHANTID, this.aCCESSTOKEN, this.nAME, this.gENERATEDDATETIME});

  get_token.fromJson(Map<String, dynamic> json) {
    mERCHANTID = json['MERCHANT_ID'];
    aCCESSTOKEN = json['ACCESS_TOKEN'];
    nAME = json['NAME'];
    gENERATEDDATETIME = json['GENERATED_DATE_TIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MERCHANT_ID'] = this.mERCHANTID;
    data['ACCESS_TOKEN'] = this.aCCESSTOKEN;
    data['NAME'] = this.nAME;
    data['GENERATED_DATE_TIME'] = this.gENERATEDDATETIME;
    return data;
  }
}
