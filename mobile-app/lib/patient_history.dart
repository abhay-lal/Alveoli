import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/api_service.dart';
import 'package:nakshatra/constants.dart';
import 'package:flutter_image/flutter_image.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PrimaryColor,
        body: FutureBuilder(
          future: APIService.getHistory(),
          builder: (BuildContext context, AsyncSnapshot model) {
            if (model.hasData) {
              var len = model.data['results'];

              return ListView.builder(
                  padding: EdgeInsets.all(50.0),
                  shrinkWrap: true,
                  itemCount: len,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Text(
                        //   model.data['data']['data'][index]['result']
                        //       .toString()
                        //       .toUpperCase(),
                        //   style: GoogleFonts.workSans(
                        //       fontSize: 25, color: SecondaryColor),
                        // ),
                        Card(shape: RoundedRectangleBorder(
                          side: BorderSide(color: SecondaryColor, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                          // child: Column(
                          //   children: [
                          //     Text(
                          //       model.data['data']['data'][index]['result']
                          //           .toString()
                          //           .toUpperCase(),
                          //       style: GoogleFonts.workSans(
                          //           fontSize: 25, color: SecondaryColor),
                          //     ),
                          //     Text(
                          //       model.data['data']['data'][0]['user']['name']
                          //           .toString()
                          //           .toUpperCase(),
                          //       style: GoogleFonts.workSans(
                          //           fontSize: 25, color: SecondaryColor),
                          //     ),
                          //     Text(
                          //       model.data['data']['data'][0]['createdAt']
                          //           .toString()
                          //           .toUpperCase().substring(0,10),
                          //       style: GoogleFonts.workSans(
                          //           fontSize: 25, color: SecondaryColor),
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  model.data['data']['data'][index]['result']
                                      .toString()
                                      .toUpperCase(),
                                  style: GoogleFonts.workSans(
                                      fontSize: 25, color: SecondaryColor),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    model.data['data']['data'][0]['user']
                                            ['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: GoogleFonts.workSans(
                                        fontSize: 25, color: SecondaryColor),
                                  ),
                                  Text(
                                    model.data['data']['data'][0]['createdAt']
                                        .toString()
                                        .toUpperCase()
                                        .substring(0, 10),
                                    style: GoogleFonts.workSans(
                                        fontSize: 25, color: SecondaryColor),
                                  ),
                                  SizedBox(height: 50,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: SecondaryColor,
              ));
            }
          },
        ));
  }
}

// Center(child: Text(model.data['data']['data'][0]['result'].toString()),);
// Image(image: NetworkImageWithRetry(model.data['data']['data'][index]['image']))
