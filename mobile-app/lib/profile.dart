

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/api_service.dart';
import 'package:nakshatra/constants.dart';
import 'package:nakshatra/login.dart';

import 'package:nakshatra/shared_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                SharedService.logout(context);

              },
              icon: Icon(
                Icons.logout_sharp,
                color: SecondaryColor,
              ))
        ],
      ),
      backgroundColor: PrimaryColor,
      body: FutureBuilder(
        future: APIService.getDetails(),
        builder: (BuildContext context, AsyncSnapshot model) {
          if (model.hasData) {
            // log(model.data.toString());

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    maxRadius: 75,
                    backgroundImage: NetworkImage(
                        model.data['data']['data']['photo'].toString())),
                SizedBox(height: 75),
                Center(
                  child: Text(
                      model.data['data']['data']['name']
                          .toString()
                          .toUpperCase(),
                      style: GoogleFonts.workSans(
                          fontSize: 25, color: SecondaryColor)),
                ),
                SizedBox(height: 75),
                Center(
                    child: Text(
                  model.data['data']['data']['email'].toString(),
                  style:
                      GoogleFonts.workSans(fontSize: 25, color: SecondaryColor),
                )),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: SecondaryColor),
          );
        },
      ),
    );
  }
}
