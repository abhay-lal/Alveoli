import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:nakshatra/config.dart';
import 'package:nakshatra/models/login_request_model.dart';
import 'package:nakshatra/models/login_response_model.dart';
import 'package:nakshatra/models/signup_request_model.dart';
import 'package:nakshatra/models/signup_response_model.dart';
import 'package:nakshatra/shared_service.dart';
class APIService{
  static Future<bool>login(LoginRequest model)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.APIUrl, Config.LoginAPI);
    var response = await http.post(url,headers: requestHeaders,body:jsonEncode(model), );
    log(response.body);
    if(response.statusCode==200){
      await SharedService.setLogInDetails(logInResponseModel(response.body));
      return true;
    }
    else {
      return false;
    }
  }
  static Future<SignUpResponseModel>register(SignUpRequest model)async{
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
    };
    var url=Uri.http(Config.APIUrl, Config.SignUpAPI);
    log(model.email);
    var response = await http.post(url,headers: requestHeaders,body:jsonEncode(model.toJson()), );

    log(response.body);
    return SignUpResponseModel(status: response.body[0],token: response.body[1] );
  }

  static Future getDetails()async{
    var loginDetails=await SharedService.LogInDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'Authorization':'Bearer ${loginDetails!.token}'
    };
    var url=Uri.http(Config.APIUrl, Config.UserDeatils);
    var response=await http.get(url,headers: requestHeaders);
    log(response.body);
    var data=jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }
    else{
      return "";
    }
  }
  static Future getHistory()async{
    var loginDetails=await SharedService.LogInDetails();
    Map<String,String> requestHeaders={
      'Content-Type':'application/json',
      'Authorization':'Bearer ${loginDetails!.token}'
    };
    var url=Uri.http(Config.APIUrl, Config.PatientHistory+"${loginDetails.data.user.id}/reports");
    var response=await http.get(url,headers: requestHeaders);
    log(response.body);
    var data=jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }
    else{
      return "";
    }
  }

}