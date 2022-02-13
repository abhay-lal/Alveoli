import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakshatra/constants.dart';
import 'package:url_launcher/url_launcher.dart';
class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}
const String _url="https://alveoli.netlify.app/";
void _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd8efed),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            "assets/921059.png",
            height: 200,
          ),
          Text(
            "This project helps users check their Chest X-Ray reports in a matter of seconds.We have created a secure Chest X-Ray image classification based website and app that can detect Covid-19, Pneumonia and Tuberculosis. Deep Learning has been used to detect the disease by using a Convolutional Neural Network(MobileNetV2) which performs classification. The user can login and upload an image of the Chest X-Ray which will be safely secured on Blockchain.The result of Chest X-Ray shall be given within seconds. In our website we have integrated Alan AI to provide a smooth workflow for all.The user can also view a history of their medical chest X-Ray reports which can be downloaded in the form of a pdf.",
            style: GoogleFonts.workSans(fontSize: 15,),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(SecondaryColor)),
              onPressed: () async{
                _launchURL();
              },
              child: Text(
                "Check out our Website",
                style: GoogleFonts.workSans(color: PrimaryColor),
              ))
        ]),
      ),
    );
  }
}
