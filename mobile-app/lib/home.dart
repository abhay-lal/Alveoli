import 'package:flutter/material.dart';
import 'package:nakshatra/constants.dart';
import 'package:nakshatra/model_upload.dart';
import 'package:nakshatra/patient_history.dart';
import 'package:nakshatra/profile.dart';
import 'about_us.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Widget> _pages = <Widget>[
    About(),
    Upload(),
    History(),
    Profile(),
  ];
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFd8efed),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xff064848),
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: PrimaryColor,
            icon: Icon(Icons.info_outline_rounded),
            label: "About Us",
          ),
          BottomNavigationBarItem(
            backgroundColor: PrimaryColor,
            icon: Icon(Icons.upload_file_outlined),
            label: "Upload Your Image",
          ),
          BottomNavigationBarItem(
            backgroundColor: PrimaryColor,
            icon: Icon(Icons.history_sharp),
            label: "Patient History",
          ),
          BottomNavigationBarItem(
            backgroundColor: PrimaryColor,
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
