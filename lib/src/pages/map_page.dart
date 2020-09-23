import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qrreader/src/models/scan_model.dart';


class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Coordinates'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {}
          )
        ],
      ),
      body: Center(
        child: _createFlutterMap(scan)
      ),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10.0
      ),
      layers: [
        _createMap()
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiZHRvbGVkb3oiLCJhIjoiY2tmZmwwbmFxMDB1ZjJzb3ZhdmtvandtbCJ9.CjwlVoy9uQIx9hQY9DL9FA',
        'id': 'mapbox/streets-v11'
      }
    );
  }
}