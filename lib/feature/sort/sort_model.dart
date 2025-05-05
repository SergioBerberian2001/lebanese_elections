class CandidateResponse {
  Data? data;
  int? error;
  String? message;

  CandidateResponse({this.data, this.error, this.message});

  CandidateResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    if (data != null) {
      jsonData['data'] = data!.toJson();
    }
    jsonData['error'] = error;
    jsonData['message'] = message;
    return jsonData;
  }
}

class Data {
  List<Candidate>? candidates;

  Data({this.candidates});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = [];
      json['candidates'].forEach((v) {
        candidates!.add(Candidate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    if (candidates != null) {
      jsonData['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class Candidate {
  int? id;
  String? name;
  bool isSelected = false;
  bool isDeleted = false;

  Candidate({this.id, this.name});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': isSelected
          ? 'added'
          : isDeleted
          ? 'deleted'
          : 'none',
    };
  }
}
