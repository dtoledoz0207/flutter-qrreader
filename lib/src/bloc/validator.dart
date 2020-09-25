import 'dart:async';

import 'package:qrreader/src/models/scan_model.dart';


class Validators {

  final validateGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((scan) => scan.type == 'geo').toList();
      sink.add(geoScans);
    }
  );

  final validateHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final httpScans = scans.where((scan) => scan.type == 'http').toList();
      sink.add(httpScans);
    }
  );

}