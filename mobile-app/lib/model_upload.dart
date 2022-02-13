import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nakshatra/constants.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

bool _loading = true;

class _UploadState extends State<Upload> {
  late XFile _image;
  List? _output;
  final ImagePicker picker = ImagePicker();

  loadXrayModel() async {
    await Tflite.loadModel(
        model: "assets/disease-check.tflite", labels: "assets/covidlabels.txt");
  }

  detectDisease(XFile? image) async {
    var output = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadXrayModel().then((value) {
      setState(() {});
    });
  }

  pickImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }
    _image = image;
    detectDisease(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd8efed),
      body: Center(
        child: _loading
            ? Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/921059.png",
                        height: 200,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff064848))),
                        onPressed: () {
                          pickImage();
                          _loading = !_loading;
                        },
                        child: Text(
                          "Upload Image",
                          style: GoogleFonts.workSans(color: PrimaryColor)
                        ),
                      )
                    ]),
              )
            : Center(
                child: Container(
                child: _output != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 500,
                            padding: EdgeInsets.all(20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(File(_image.path)),
                            ),
                          ),
                          Text(
                            "Your chest X-ray is classified as ${_output?[0]['label']} ",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff064848))),
                              onPressed: () {
                                setState(() {
                                  _loading = !_loading;
                                });
                              },
                              child: Text(
                                "Upload Again",
                                style: TextStyle(color: Color(0xffd8efed)),
                              ))
                        ],
                      )
                    : Text("data"),
              )),
      ),
    );
  }
}
