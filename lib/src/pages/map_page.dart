import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qrreader/src/models/scan_model.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}


class _MapPageState extends State<MapPage> {

  final mapCtrl = MapController();
  String mapType = 'streets-v11';

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
      floatingActionButton: _createFloatingActionButton(context, scan),
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
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiZHRvbGVkb3oiLCJhIjoiY2tmZmwwbmFxMDB1ZjJzb3ZhdmtvandtbCJ9.CjwlVoy9uQIx9hQY9DL9FA',
        'id': 'mapbox/$mapType'
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

  Widget _createFloatingActionButton(BuildContext context, ScanModel scan) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        // streets-v11, dark-v10, light-v10, outdoors-v11, satellite-v9, satellite-streets-v11

        setState(() {
          if (mapType == 'streets-v11') {
            mapType = 'dark-v10';
          } else if (mapType == 'dark-v10') {
            mapType = 'light-v10';
          } else if (mapType == 'light-v10') {
            mapType = 'outdoors-v11';
          } else if (mapType == 'outdoors-v11') {
            mapType = 'satellite-streets-v11';
          } else {
            mapType = 'streets-v11';
          }
        });

        mapCtrl.move(scan.getLatLng(), 20);

        Future.delayed(Duration(milliseconds: 50), () {
          mapCtrl.move(scan.getLatLng(), 15.0);
        });
      }
    );
  }
}