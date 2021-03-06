import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class DirectionsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
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
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Color.fromRGBO(255, 142, 118, 1.0)),
                  onDismissed: (direction) => scansBloc.deleteScan(scans[index].id),
                  child: ListTile(
                    leading: Icon(Icons.open_in_browser, color: Theme.of(context).primaryColor),
                    title: Text(scans[index].value),
                    subtitle: Text('ID: ${scans[index].id}'),
                    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                    onTap: () {
                      utils.openScan(context, scans[index]);
                    },
                  )
                );
              }
            );
          }

        }

      }
    );
  }
}