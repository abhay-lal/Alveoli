import 'dart:developer';

class SignUpRequest {
  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });
  late final String name;
  late final String email;
  late final String password;
  late final String passwordConfirm;

  SignUpRequest.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordConfirm = json['passwordConfirm'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['passwordConfirm'] = passwordConfirm;
    log(_data.toString());
    return _data;
  }
}