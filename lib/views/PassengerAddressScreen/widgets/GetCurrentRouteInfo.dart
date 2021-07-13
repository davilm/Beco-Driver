import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beco_driver/views/PassengerAddressScreen/widgets/PassengersAddressWidget.dart';

class GetCurrentRouteInfo extends StatefulWidget {
  final String selectedRoute;

  GetCurrentRouteInfo({
    required this.selectedRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<GetCurrentRouteInfo> createState() => _GetCurrentRouteInfoState();
}

class _GetCurrentRouteInfoState extends State<GetCurrentRouteInfo> {
  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

    return FutureBuilder<DocumentSnapshot>(
      future: routes.doc(widget.selectedRoute).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong $snapshot.error"));
        }

        try {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          try {
            return ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: data['passengersList'].length,
              itemBuilder: (context, index) => PassengersAddressWidget(
                data['passengersList'][index]['name'],
                data['passengersList'][index]['address'],
                key: ValueKey(data['passengersList']),
              ),
            );
          } catch (e) {
            return Center(
              child: Text("nenhum passageiro adicionado a rota"),
            );
          }
        } catch (e) {
          return Center(child: Text("nenhuma rota encontrada"));
        }
      },
    );
  }
}
