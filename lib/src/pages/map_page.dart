import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qrreader/src/models/scan_model.dart';


class MapPage extends StatelessWidget {

  final mapCtrl = MapController();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Coordinates'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCtrl.move(scan.getLatLng(), 15.0);
            }
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
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0
      ),
      layers: [
        _createMap(),
        _createMarks(scan)
      ],
    );
  }

  _createMap() {
    // streets-v11, dark-v10, light-v10, outdoors-v11, satellite-v9, satellite-streets-v11
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiZHRvbGVkb3oiLCJhIjoiY2tmZmwwbmFxMDB1ZjJzb3ZhdmtvandtbCJ9.CjwlVoy9uQIx9hQY9DL9FA',
        'id': 'mapbox/streets-v11'
      }
    );
  }

  _createMarks(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 50.0, color: Theme.of(context).primaryColor),
          )
        )
      ]
    );
  }
}