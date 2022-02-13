import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/login.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'dart:developer';
import 'api_service.dart';
import 'config.dart';
import 'home.dart';
import 'model_upload.dart';
import 'models/login_request_model.dart';
import 'models/signup_request_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> emailformkey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordformkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String password = "";
  bool hidepassword = true;

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
        padding: EdgeInsets.all(50),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage("assets/921059.png"),
              height: 100,
            ),
            Form(
                child: TextFormField(
                  cursorColor: Color(0xff064848),
                  controller: _nameController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person_outline_sharp,
                        color: Color(0xff064848),
                      ),
                      label: Text(
                        "Name",
                        style: TextStyle(color: Color(0xff064848)),
                      )),
                  validator: MinLengthValidator(4,
                      errorText: "Name should be atleast 4 Characters"),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction),
            Form(
                key: emailformkey,
                child: TextFormField(
                  cursorColor: Color(0xFF064848),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email_sharp,
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
                autovalidateMode: AutovalidateMode.onUserInteraction),
            Form(
                key: passwordformkey,
                child: TextFormField(
                  cursorColor: Color(0xFF064848),
                  controller: _passwordController,
                  onChanged: (value) => password = value,
                  obscureText: _toggle,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.lock_outlined,
                        color: Color(0xFF064848),
                      ),
                      label: Text(
                        "Password",
                        style: TextStyle(color: Color(0xFF064848)),
                      )),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText:
                              "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                              "Password should not be greater than 15 characters"),
                      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                              'Password must have at least one special character')
                    ],
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction),
            Form(
              child: TextFormField(
                cursorColor: Color(0xFF064848),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock_outlined,
                      color: Color(0xFF064848),
                    ),
                    label: Text(
                      "Re Enter Password",
                      style: TextStyle(color: Color(0xFF064848)),
                    )),
                validator: (val) =>
                    MatchValidator(errorText: "Passwords Don't Match")
                        .validateMatch(val.toString(), password),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF064848))),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LogIn()),
                      (route) => false);

                  setState(() {
                    //HUDloader
                    SignUpRequest model = SignUpRequest(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        passwordConfirm: _passwordController.text);
                    log(model.name);
                    APIService.register(model).then((response) {
                      if (response != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Upload().toString(), (route) => false);
                        log(response.toString());
                      } else {
                        FormHelper.showSimpleAlertDialog(
                            context, Config.APIUrl, "Invalid User", "OK", () {
                          Navigator.pop(context);
                          log(response.toString());
                        });
                      }
                    });
                  });
                  ;
                },
                child: Text(
                  "Signup",
                  style: TextStyle(color: Color(0xFFd8efed)),
                )),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LogIn()));
                },
                child: Text(
                  "Already have an account? Log In here.",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                )),
          ],
        ),
      ),
    );
  }
}
