
import 'package:http/http.dart'as http;
class Config{
  static  String APIUrl=Uri.parse("nakshatra-demo.herokuapp.com").toString();
  static const String LoginAPI="/api/users/login";
  static const String SignUpAPI="/api/users/signup";
  static const String UserDeatils="/api/users/me";
  static const String PatientHistory="/api/users/";
}