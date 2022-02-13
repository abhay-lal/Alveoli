import 'dart:convert';
SignUpResponseModel signUpResponseModel(String str)=>SignUpResponseModel.fromJson(json.decode(str));

class SignUpResponseModel {
  SignUpResponseModel({
    required this.status,
    required this.token,

  });
  late final String status;
  late final String token;
  late final Data data;

  SignUpResponseModel.fromJson(Map<String, dynamic> json){
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

  Data.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  var id;

  var V;

  User({
    required this.photo,
    required this.role,
    required this.active,
    required this.id,
    required this.name,
    required this.email,
    required this.V,
  });
  late final String photo;
  late final String role;
  late final bool active;
  late final String _id;
  late final String name;
  late final String email;
  late final int _V;

  User.fromJson(Map<String, dynamic> json){
    photo = json['photo'];
    role = json['role'];
    active = json['active'];
    _id = json['_id'];
    name = json['name'];
    email = json['email'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo;
    _data['role'] = role;
    _data['active'] = active;
    _data['_id'] = _id;
    _data['name'] = name;
    _data['email'] = email;
    _data['__v'] = _V;
    return _data;
  }
}