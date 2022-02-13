import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/api_service.dart';
import 'package:nakshatra/config.dart';
import 'package:nakshatra/home.dart';
import 'package:nakshatra/constants.dart';
import 'package:nakshatra/model_upload.dart';
import 'package:nakshatra/models/login_request_model.dart';
import 'package:nakshatra/signup.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> emailformkey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordformkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _toggle = true;
    return Scaffold(
      backgroundColor: Color(0xFFd8efed),
      appBar: AppBar(
        backgroundColor: Color(0xFF064848),
        title: Text(
          'Alveoli',
          style: GoogleFonts.getFont('Work Sans'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Image(
              image: AssetImage("assets/921059.png"),
              height: 100,
            ),
            Form(
              key: emailformkey,
              child: TextFormField(
                cursorColor: Color(0xFF064848),
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_outline_sharp,
                      color: Color(0xFF064848),
                    ),
                    label: Text(
                      "Email ID",
                      style: TextStyle(color: Color(0xFF064848)),
                    )),
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "* Required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ],
                ),
              ),
            ),
            Form(
                key: passwordformkey,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _toggle,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outlined,
                        color: Color(0xFF064848),
                      ),
                      label: Text(
                        "Password",
                        style: TextStyle(color: Color(0xFF064848)),
                      )),

                ),
                autovalidateMode: AutovalidateMode.onUserInteraction),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xFF064848))),
              child:
                  Text("Log In", style: TextStyle(color: Color(0xFFd8efed))),
              onPressed: () {
                setState(() {
                  //HUDloader
                  LoginRequest model = LoginRequest(
                      email: _emailController.text,
                      password: _passwordController.text);
                  APIService.login(model).then((response) {
                    log(response.toString());
                    if (response) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()),
                          (route) => false);
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.APIUrl, "Invalid User", "OK", () {
                        Navigator.pop(context);
                      });
                    }
                  });
                });
              },
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUp()));
                },
                child: Text("Don't have an account? Sign Up Here!",style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    decoration: TextDecoration.underline),)),
          ],
        ),
      ),
    );
  }
}
