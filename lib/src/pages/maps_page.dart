import 'package:flutter/material.dart';

import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';

class MapsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          
          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('There is not information'),
            );
          } else {
            return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Color.fromRGBO(255, 142, 118, 1.0)),
                onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
                  title: Text(scans[i].value),
                  subtitle: Text('ID: ${scans[i].id}'),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                )
              )
            );
          }

        }

      }
    );
  }
}