import 'dart:io';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

import 'package:qrreader/src/pages/directions_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans
          )
        ],
      ),
      body: _callPage(currentIndexPage),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _scanQR(context),
      ),
    );
  }

  _scanQR(BuildContext context) async {

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
      scansBloc.addNewScan(scan);

      /*final scan2 = ScanModel(value: 'geo:19.24746239468022,-103.72395887812503');
      scansBloc.addNewScan(scan2);*/

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), (){
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
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