import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beco_driver/views/MyRoutes/widgets/RouteCard.dart';

class GetAllRoutesInfo extends StatefulWidget {
  final String driverUid;

  GetAllRoutesInfo(
    this.driverUid, {
    Key? key,
  }) : super(key: key);

  @override
  State<GetAllRoutesInfo> createState() => _GetAllRoutesInfoState();
}

class _GetAllRoutesInfoState extends State<GetAllRoutesInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('routes')
            .where("driverUid", isEqualTo: widget.driverUid)
            .orderBy('date')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong $snapshot.error"));
          }

          final routeDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: routeDocs.length,
            itemBuilder: (context, index) => RouteCard(
              routeDocs[index]['startTrip'],
              routeDocs[index]['endTrip'],
              routeDocs[index]['date'],
              routeDocs[index]['price'].toString(),
              key: ValueKey(routeDocs[index].id),
            ),
          );
        },
      ),
    );
  }
}
