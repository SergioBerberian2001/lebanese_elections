class TermsPrivacyModel {
  Data? data;
  int? error;
  String? message;

  TermsPrivacyModel({this.data, this.error, this.message});

  TermsPrivacyModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  TermsPrivacy? termsPrivacy;

  Data({this.termsPrivacy});

  Data.fromJson(Map<String, dynamic> json) {
    termsPrivacy = json['terms_privacy'] != null
        ? new TermsPrivacy.fromJson(json['terms_privacy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.termsPrivacy != null) {
      data['terms_privacy'] = this.termsPrivacy!.toJson();
    }
    return data;
  }
}

class TermsPrivacy {
  String? terms;
  String? privacy;

  TermsPrivacy({this.terms, this.privacy});

  TermsPrivacy.fromJson(Map<String, dynamic> json) {
    terms = json['terms'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    return data;
  }
}
