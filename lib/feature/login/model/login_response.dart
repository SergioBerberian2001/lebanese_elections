class LoginResponse {
  Data? data;
  bool? error;
  String? message;

  LoginResponse({this.data, this.error, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? avatar;
  String? loginWith;
  String? location;
  String? box;
  String? loginWithSocail;
  bool? isBlocked;
  String? driverIdentityNumber;
  String? driverVehicleSequenceNumber;
  List<UserRoles>? userRoles;

  User(
      {this.id,
        this.name,
        this.phoneNumber,
        this.email,
        this.avatar,
        this.location,
        this.box,
        this.loginWith,
        this.loginWithSocail,
        this.isBlocked,
        this.driverIdentityNumber,
        this.driverVehicleSequenceNumber,
        this.userRoles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    box = json['box'];
    location = json['location'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    avatar = json['avatar'];
    loginWith = json['login_with'];
    loginWithSocail = json['login_with_socail'];
    isBlocked = json['is_blocked'];
    driverIdentityNumber = json['driverIdentityNumber'];
    driverVehicleSequenceNumber = json['driver_vehicleSequenceNumber'];
    if (json['user_roles'] != null) {
      userRoles = <UserRoles>[];
      json['user_roles'].forEach((v) {
        userRoles!.add(new UserRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['box'] = this.box;
    data['location'] = this.location;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['login_with'] = this.loginWith;
    data['login_with_socail'] = this.loginWithSocail;
    data['is_blocked'] = this.isBlocked;
    data['driverIdentityNumber'] = this.driverIdentityNumber;
    data['driver_vehicleSequenceNumber'] = this.driverVehicleSequenceNumber;
    if (this.userRoles != null) {
      data['user_roles'] = this.userRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRoles {
  int? roleId;
  String? roleName;

  UserRoles({this.roleId, this.roleName});

  UserRoles.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    return data;
  }
}
