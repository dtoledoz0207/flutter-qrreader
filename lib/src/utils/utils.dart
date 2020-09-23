import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qrreader/src/models/scan_model.dart';

openScan(BuildContext context, ScanModel scan) async {

  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    print('GEO...');
    Navigator.pushNamed(context, 'map', arguments: scan);
  }

}