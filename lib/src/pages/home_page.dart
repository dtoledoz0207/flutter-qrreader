import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreader/src/models/scan_model.dart';

import 'package:qrreader/src/providers/db_provider.dart';

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
      appBar: AppBar(
        title: Text('QR Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {}
          )
        ],
      ),
      body: _callPage(currentIndexPage),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _scanQR,
      ),
    );
  }

  _scanQR() async {

    // https://fernando-herrera.com/
    // geo:19.24746239468022,-103.72395887812503

    dynamic futureString = "https://fernando-herrera.com/";

    /* try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    print('*********************************************************');
    print('Future String: ${futureString.rawContent}');
    print('*********************************************************');

    */

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      DBProvider.db.newScan(scan);
    }
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