import 'dart:convert';

LogInResponseModel logInResponseModel(String str) =>
    LogInResponseModel.fromJson(json.decode(str));

class LogInResponseModel {
  LogInResponseModel({
    required this.status,
    required this.token,
    required this.data,
  });

  late final String status;
  late final String token;
  late final Data data;

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['token'] = token;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.user,
  });

  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.photo,
    required this.role,
    required this.id,
    required this.name,
    required this.email,
  });

  late final String photo;
  late final String role;
  late final String id;
  late final String name;
  late final String email;

  User.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    role = json['role'];
    id = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo;
    _data['role'] = role;
    _data['_id'] = id;
    _data['name'] = name;
    _data['email'] = email;

    return _data;
  }
}
