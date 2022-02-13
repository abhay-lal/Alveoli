import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/home.dart';
import 'package:nakshatra/login.dart';
import 'package:nakshatra/shared_service.dart';

import 'package:nakshatra/splashscreen.dart';
Widget _defaultHome=const LogIn();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool _result=await SharedService.isLoggedIn();
  if(_result){
    _defaultHome=Home();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
