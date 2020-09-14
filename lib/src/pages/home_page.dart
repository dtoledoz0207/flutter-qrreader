import 'package:flutter/material.dart';

import 'package:qrreader/src/pages/directions_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndexPage),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }


  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0: return MapsPage();
      case 1: return DirectionsPage();
      default:
        return MapsPage();
    }
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndexPage,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web),
          title: Text('urls')
        )
      ],
      onTap: (index) {
        setState(() {
          currentIndexPage = index;
        });
      },
    );
  }
}