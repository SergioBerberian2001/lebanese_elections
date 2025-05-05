class VoterModelResponse {
  Data? data;
  int? error;
  String? message;

  VoterModelResponse({this.data, this.error, this.message});

  VoterModelResponse.fromJson(Map<String, dynamic> json) {
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
  List<Voters>? voters;
  Links? links;

  Data({this.voters, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['voters'] != null) {
      voters = <Voters>[];
      json['voters'].forEach((v) {
        voters!.add(new Voters.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.voters != null) {
      data['voters'] = this.voters!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Voters {
  int? id;
  String? name;
  String? motherName;
  String? dateOfBirth;
  int? registrationNumber;

  Voters(
      {this.id,
        this.name,
        this.motherName,
        this.dateOfBirth,
        this.registrationNumber});

  Voters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    motherName = json['mother_name'];
    dateOfBirth = json['date_of_birth'];
    registrationNumber = json['registration_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mother_name'] = this.motherName;
    data['date_of_birth'] = this.dateOfBirth;
    data['registration_number'] = this.registrationNumber;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? next;
  String? prev;
  int? lastPageNumber;

  Links({this.first, this.last, this.next, this.prev, this.lastPageNumber});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    next = json['next'];
    prev = json['prev'];
    lastPageNumber = json['last_page_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['next'] = this.next;
    data['prev'] = this.prev;
    data['last_page_number'] = this.lastPageNumber;
    return data;
  }
}
